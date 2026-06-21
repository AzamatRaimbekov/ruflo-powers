param(
  [string]$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

function Assert-PathExists {
  param(
    [string]$Root,
    [string]$RelativePath,
    [string]$Kind = 'Any'
  )

  $fullPath = Join-Path $Root $RelativePath
  if ($Kind -eq 'Directory') {
    if (-not (Test-Path -LiteralPath $fullPath -PathType Container)) {
      throw "Missing directory: $RelativePath"
    }
    return
  }

  if ($Kind -eq 'File') {
    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
      throw "Missing file: $RelativePath"
    }
    return
  }

  if (-not (Test-Path -LiteralPath $fullPath)) {
    throw "Missing path: $RelativePath"
  }
}

function Assert-FileContains {
  param(
    [string]$Root,
    [string]$RelativePath,
    [string]$Expected
  )

  $fullPath = Join-Path $Root $RelativePath
  $content = Get-Content -LiteralPath $fullPath -Raw
  if (-not $content.Contains($Expected)) {
    throw "Expected $RelativePath to contain: $Expected"
  }
}

function Assert-ClaudePluginDirectoryCatalog {
  param(
    [string]$Root,
    [string]$RelativePath
  )

  $fullPath = Join-Path $Root $RelativePath
  $catalog = Get-Content -LiteralPath $fullPath -Raw | ConvertFrom-Json

  if ($catalog.source.url -ne 'https://claude.com/plugins') {
    throw "Claude plugin directory catalog has unexpected source URL: $RelativePath"
  }

  if (-not $catalog.template.single_file_configuration) {
    throw "Claude plugin directory catalog must declare single_file_configuration: $RelativePath"
  }

  if (-not $catalog.capability_types -or
      -not ($catalog.capability_types -contains 'plugin') -or
      -not ($catalog.capability_types -contains 'mcp') -or
      -not ($catalog.capability_types -contains 'skill')) {
    throw "Claude plugin directory catalog must include plugin, mcp, and skill capability types: $RelativePath"
  }

  if (-not $catalog.plugins -or $catalog.plugins.Count -lt 80) {
    throw "Expected at least 80 Claude plugin directory entries, found $($catalog.plugins.Count)"
  }
}

function Assert-ClaudePluginDirectoryPackages {
  param(
    [string]$Root,
    [string]$CatalogRelativePath,
    [string]$PackagesRelativePath
  )

  $catalog = Get-Content -LiteralPath (Join-Path $Root $CatalogRelativePath) -Raw | ConvertFrom-Json
  $packagesRoot = Join-Path $Root $PackagesRelativePath

  if (-not (Test-Path -LiteralPath $packagesRoot -PathType Container)) {
    throw "Missing Claude plugin package directory: $PackagesRelativePath"
  }

  $packageDirs = Get-ChildItem -LiteralPath $packagesRoot -Directory
  if ($packageDirs.Count -lt $catalog.plugins.Count) {
    throw "Expected at least $($catalog.plugins.Count) Claude plugin package folders, found $($packageDirs.Count)"
  }

  foreach ($plugin in $catalog.plugins) {
    $expectedPackagePath = ($PackagesRelativePath.TrimEnd('\') + '\' + $plugin.slug)
    $expectedPackagePathUnix = $expectedPackagePath -replace '\\', '/'

    if ($plugin.local_package_path -ne $expectedPackagePathUnix) {
      throw "Catalog entry $($plugin.slug) has unexpected local_package_path: $($plugin.local_package_path)"
    }

    Assert-PathExists -Root $Root -RelativePath $expectedPackagePath -Kind 'Directory'
    Assert-PathExists -Root $Root -RelativePath (Join-Path $expectedPackagePath 'manifest.json') -Kind 'File'
    Assert-PathExists -Root $Root -RelativePath (Join-Path $expectedPackagePath 'README.md') -Kind 'File'
    Assert-PathExists -Root $Root -RelativePath (Join-Path $expectedPackagePath '.claude-plugin\plugin.json') -Kind 'File'
    Assert-PathExists -Root $Root -RelativePath (Join-Path $expectedPackagePath 'capabilities\plugin.json') -Kind 'File'

    if ($plugin.capabilities -contains 'mcp') {
      Assert-PathExists -Root $Root -RelativePath (Join-Path $expectedPackagePath 'capabilities\mcp.json') -Kind 'File'
    }

    if ($plugin.capabilities -contains 'skill') {
      Assert-PathExists -Root $Root -RelativePath (Join-Path $expectedPackagePath 'capabilities\skill.md') -Kind 'File'
    }

    $manifest = Get-Content -LiteralPath (Join-Path $Root (Join-Path $expectedPackagePath 'manifest.json')) -Raw | ConvertFrom-Json
    if ($manifest.slug -ne $plugin.slug -or $manifest.source.url -ne $plugin.url) {
      throw "Claude plugin package manifest does not match catalog entry: $($plugin.slug)"
    }
  }
}

function Assert-JsonFile {
  param(
    [string]$Root,
    [string]$RelativePath
  )

  try {
    return Get-Content -LiteralPath (Join-Path $Root $RelativePath) -Raw | ConvertFrom-Json
  } catch {
    throw "Invalid JSON in $RelativePath`: $($_.Exception.Message)"
  }
}

function Assert-CodeReviewGraphBundle {
  param(
    [string]$Root,
    [string]$RelativePath
  )

  Assert-PathExists -Root $Root -RelativePath $RelativePath -Kind 'Directory'

  foreach ($requiredFile in @(
    'manifest.json',
    '.mcp.json',
    'pyproject.toml',
    'README.md',
    'LICENSE',
    '.codex-plugin\plugin.json',
    '.claude-plugin\plugin.json',
    'hooks\hooks.json',
    'code_review_graph\__init__.py',
    'code_review_graph\cli.py'
  )) {
    Assert-PathExists -Root $Root -RelativePath (Join-Path $RelativePath $requiredFile) -Kind 'File'
  }

  foreach ($skillName in @(
    'build-graph',
    'debug-issue',
    'explore-codebase',
    'refactor-safely',
    'review-changes',
    'review-delta',
    'review-pr'
  )) {
    Assert-PathExists -Root $Root -RelativePath (Join-Path $RelativePath "skills\$skillName\SKILL.md") -Kind 'File'
  }

  $mcp = Assert-JsonFile -Root $Root -RelativePath (Join-Path $RelativePath '.mcp.json')
  $server = $mcp.mcpServers.'code-review-graph'
  if (-not $server -or $server.command -ne 'uvx' -or -not ($server.args -contains 'code-review-graph') -or -not ($server.args -contains 'serve')) {
    throw "Code Review Graph MCP config must run uvx code-review-graph serve: $RelativePath\.mcp.json"
  }

  $manifest = Assert-JsonFile -Root $Root -RelativePath (Join-Path $RelativePath 'manifest.json')
  if ($manifest.slug -ne 'code-review-graph' -or $manifest.source.repository -ne 'https://github.com/tirth8205/code-review-graph') {
    throw "Code Review Graph manifest has unexpected source metadata: $RelativePath\manifest.json"
  }
}

$templateRoot = Join-Path $ProjectRoot 'Template Project'

Assert-PathExists -Root $ProjectRoot -RelativePath 'Template Project' -Kind 'Directory'
Assert-PathExists -Root $templateRoot -RelativePath 'AGENTS.md' -Kind 'File'
Assert-PathExists -Root $templateRoot -RelativePath 'AgentMD.md' -Kind 'File'
Assert-PathExists -Root $templateRoot -RelativePath 'FEATURE.md' -Kind 'File'
Assert-PathExists -Root $templateRoot -RelativePath 'README.md' -Kind 'File'
Assert-PathExists -Root $templateRoot -RelativePath 'agent-assets' -Kind 'Directory'
Assert-PathExists -Root $templateRoot -RelativePath 'agent-assets\claude-plugin-directory.config.json' -Kind 'File'
Assert-PathExists -Root $templateRoot -RelativePath 'agent-assets\claude-plugin-directory\plugins' -Kind 'Directory'
Assert-PathExists -Root $templateRoot -RelativePath 'agent-assets\code-review-graph' -Kind 'Directory'
Assert-PathExists -Root $templateRoot -RelativePath 'agent-assets\superpowers\.codex-plugin\plugin.json' -Kind 'File'
Assert-PathExists -Root $templateRoot -RelativePath 'docs\wiki\index.md' -Kind 'File'
Assert-PathExists -Root $templateRoot -RelativePath 'docs\frontend\README.md' -Kind 'File'
Assert-PathExists -Root $templateRoot -RelativePath 'docs\frontend\design.md' -Kind 'File'
Assert-PathExists -Root $templateRoot -RelativePath 'docs\frontend\audit-checklist.md' -Kind 'File'

$requiredSkills = @(
  'agent-assets\prompt-refiner\SKILL.md',
  'agent-assets\project-documentation-wiki\SKILL.md',
  'agent-assets\superpowers\skills\using-superpowers\SKILL.md',
  'agent-assets\superpowers\skills\brainstorming\SKILL.md',
  'agent-assets\superpowers\skills\writing-plans\SKILL.md',
  'agent-assets\superpowers\skills\executing-plans\SKILL.md',
  'agent-assets\superpowers\skills\dispatching-parallel-agents\SKILL.md',
  'agent-assets\superpowers\skills\subagent-driven-development\SKILL.md',
  'agent-assets\superpowers\skills\test-driven-development\SKILL.md',
  'agent-assets\superpowers\skills\systematic-debugging\SKILL.md',
  'agent-assets\superpowers\skills\requesting-code-review\SKILL.md',
  'agent-assets\superpowers\skills\receiving-code-review\SKILL.md',
  'agent-assets\superpowers\skills\verification-before-completion\SKILL.md',
  'agent-assets\superpowers\skills\finishing-a-development-branch\SKILL.md',
  'agent-assets\superpowers\skills\using-git-worktrees\SKILL.md',
  'agent-assets\superpowers\skills\writing-skills\SKILL.md',
  'agent-assets\frontend\skills\frontend-agent\SKILL.md',
  'agent-assets\frontend\skills\design-system-steward\SKILL.md',
  'agent-assets\frontend\skills\frontend-error-ux\SKILL.md',
  'agent-assets\frontend-design-plugin\skills\frontend-design\SKILL.md',
  'agent-assets\ui-ux-pro-max\SKILL.md',
  'agent-assets\code-reviewer\SKILL.md',
  'agent-assets\backend-patterns\SKILL.md',
  'agent-assets\backend\skills\backend-engineering\SKILL.md',
  'agent-assets\backend\skills\backend-api-contracts\SKILL.md',
  'agent-assets\backend\skills\backend-data-persistence\SKILL.md',
  'agent-assets\backend\skills\backend-security-auth\SKILL.md',
  'agent-assets\backend\skills\backend-reliability-observability\SKILL.md',
  'agent-assets\backend\skills\backend-performance-scaling\SKILL.md',
  'agent-assets\backend\skills\backend-framework-patterns\SKILL.md',
  'agent-assets\backend\skills\backend-code-review\SKILL.md',
  'agent-assets\backend\skills\backend-golang\SKILL.md',
  'agent-assets\backend\skills\backend-fastapi\SKILL.md',
  'agent-assets\backend\skills\backend-django\SKILL.md',
  'agent-assets\code-review-graph\skills\review-pr\SKILL.md',
  'agent-assets\code-review-graph\skills\review-changes\SKILL.md',
  'agent-assets\code-review-graph\skills\review-delta\SKILL.md',
  'agent-assets\react-19-frontend-agent\skills\react-19-frontend-agent\SKILL.md',
  'agent-assets\react-19-frontend-agent\skills\react-19-patterns\SKILL.md',
  'agent-assets\react-19-frontend-agent\skills\typescript-react-routing\SKILL.md',
  'agent-assets\react-19-frontend-agent\skills\nextjs-app-router-practices\SKILL.md'
)

foreach ($skill in $requiredSkills) {
  Assert-PathExists -Root $templateRoot -RelativePath $skill -Kind 'File'
  Assert-FileContains -Root $templateRoot -RelativePath 'AGENTS.md' -Expected ($skill -replace '\\', '/')
  Assert-FileContains -Root $templateRoot -RelativePath 'AgentMD.md' -Expected ($skill -replace '\\', '/')
}

Assert-FileContains -Root $templateRoot -RelativePath 'AGENTS.md' -Expected 'PROJECT-LOCAL-AGENT-ASSETS'
Assert-FileContains -Root $templateRoot -RelativePath 'AGENTS.md' -Expected 'Prompt Refinement'
Assert-FileContains -Root $templateRoot -RelativePath 'AGENTS.md' -Expected 'Superpowers'
Assert-FileContains -Root $templateRoot -RelativePath 'AGENTS.md' -Expected 'Imported Standalone Skills'
Assert-FileContains -Root $templateRoot -RelativePath 'AGENTS.md' -Expected 'Backend Skill Pack'
Assert-FileContains -Root $templateRoot -RelativePath 'AGENTS.md' -Expected 'Frontend Project Startup'
Assert-FileContains -Root $templateRoot -RelativePath 'AGENTS.md' -Expected 'Test-First Development'
Assert-FileContains -Root $templateRoot -RelativePath 'AGENTS.md' -Expected 'frontend-error-ux'
Assert-FileContains -Root $templateRoot -RelativePath 'AGENTS.md' -Expected 'agent-assets/claude-plugin-directory.config.json'
Assert-FileContains -Root $templateRoot -RelativePath 'AGENTS.md' -Expected 'agent-assets/claude-plugin-directory/plugins/'
Assert-FileContains -Root $templateRoot -RelativePath 'AgentMD.md' -Expected 'AGENTS.md is the Codex-readable source of truth'
Assert-FileContains -Root $templateRoot -RelativePath 'AgentMD.md' -Expected 'agent-assets/claude-plugin-directory.config.json'
Assert-FileContains -Root $templateRoot -RelativePath 'AgentMD.md' -Expected 'agent-assets/claude-plugin-directory/plugins/'

Assert-ClaudePluginDirectoryCatalog -Root $templateRoot -RelativePath 'agent-assets\claude-plugin-directory.config.json'
Assert-ClaudePluginDirectoryPackages -Root $templateRoot -CatalogRelativePath 'agent-assets\claude-plugin-directory.config.json' -PackagesRelativePath 'agent-assets\claude-plugin-directory\plugins'
Assert-CodeReviewGraphBundle -Root $templateRoot -RelativePath 'agent-assets\code-review-graph'

$skillCount = (Get-ChildItem -LiteralPath (Join-Path $templateRoot 'agent-assets') -Recurse -Filter 'SKILL.md').Count
$agentCount = (Get-ChildItem -LiteralPath (Join-Path $templateRoot 'agent-assets') -Recurse -Filter 'openai.yaml').Count

if ($skillCount -lt 45) {
  throw "Expected at least 45 template skills, found $skillCount"
}

if ($agentCount -lt 37) {
  throw "Expected at least 37 template agent files, found $agentCount"
}

Write-Host "Template Project verification passed."
Write-Host "Template: $templateRoot"
Write-Host "Skills: $skillCount"
Write-Host "Agents: $agentCount"
