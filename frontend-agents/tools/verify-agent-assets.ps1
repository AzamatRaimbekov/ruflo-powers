param(
  [string]$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

function Assert-PathExists {
  param(
    [string]$RelativePath,
    [string]$Kind = 'Any'
  )

  $fullPath = Join-Path $ProjectRoot $RelativePath
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

function Assert-OldRootFolderMoved {
  param([string]$RelativePath)

  $fullPath = Join-Path $ProjectRoot $RelativePath
  if (Test-Path -LiteralPath $fullPath) {
    throw "Expected old root folder to be moved: $RelativePath"
  }
}

function Read-JsonFile {
  param([string]$RelativePath)

  $fullPath = Join-Path $ProjectRoot $RelativePath
  try {
    return Get-Content -LiteralPath $fullPath -Raw | ConvertFrom-Json
  } catch {
    throw "Invalid JSON in $RelativePath`: $($_.Exception.Message)"
  }
}

function Assert-ClaudePluginDirectoryCatalog {
  param([string]$RelativePath)

  $catalog = Read-JsonFile -RelativePath $RelativePath

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

  foreach ($requiredSlug in @('frontend-design', 'superpowers', 'context7', 'github', 'playwright', 'figma')) {
    if (-not ($catalog.plugins | Where-Object { $_.slug -eq $requiredSlug })) {
      throw "Claude plugin directory catalog is missing required plugin slug: $requiredSlug"
    }
  }
}

function Assert-ClaudePluginDirectoryPackages {
  param(
    [string]$CatalogRelativePath,
    [string]$PackagesRelativePath
  )

  $catalog = Read-JsonFile -RelativePath $CatalogRelativePath
  $packagesRoot = Join-Path $ProjectRoot $PackagesRelativePath

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

    Assert-PathExists -RelativePath $expectedPackagePath -Kind 'Directory'
    Assert-PathExists -RelativePath (Join-Path $expectedPackagePath 'manifest.json') -Kind 'File'
    Assert-PathExists -RelativePath (Join-Path $expectedPackagePath 'README.md') -Kind 'File'
    Assert-PathExists -RelativePath (Join-Path $expectedPackagePath '.claude-plugin\plugin.json') -Kind 'File'
    Assert-PathExists -RelativePath (Join-Path $expectedPackagePath 'capabilities\plugin.json') -Kind 'File'

    if ($plugin.capabilities -contains 'mcp') {
      Assert-PathExists -RelativePath (Join-Path $expectedPackagePath 'capabilities\mcp.json') -Kind 'File'
    }

    if ($plugin.capabilities -contains 'skill') {
      Assert-PathExists -RelativePath (Join-Path $expectedPackagePath 'capabilities\skill.md') -Kind 'File'
    }

    $manifest = Read-JsonFile -RelativePath (Join-Path $expectedPackagePath 'manifest.json')
    if ($manifest.slug -ne $plugin.slug -or $manifest.source.url -ne $plugin.url) {
      throw "Claude plugin package manifest does not match catalog entry: $($plugin.slug)"
    }
  }
}

function Assert-CodeReviewGraphBundle {
  param([string]$RelativePath)

  Assert-PathExists -RelativePath $RelativePath -Kind 'Directory'

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
    Assert-PathExists -RelativePath (Join-Path $RelativePath $requiredFile) -Kind 'File'
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
    Assert-PathExists -RelativePath (Join-Path $RelativePath "skills\$skillName\SKILL.md") -Kind 'File'
  }

  $mcp = Read-JsonFile -RelativePath (Join-Path $RelativePath '.mcp.json')
  $server = $mcp.mcpServers.'code-review-graph'
  if (-not $server -or $server.command -ne 'uvx' -or -not ($server.args -contains 'code-review-graph') -or -not ($server.args -contains 'serve')) {
    throw "Code Review Graph MCP config must run uvx code-review-graph serve: $RelativePath\.mcp.json"
  }

  $manifest = Read-JsonFile -RelativePath (Join-Path $RelativePath 'manifest.json')
  if ($manifest.slug -ne 'code-review-graph' -or $manifest.source.repository -ne 'https://github.com/tirth8205/code-review-graph') {
    throw "Code Review Graph manifest has unexpected source metadata: $RelativePath\manifest.json"
  }
}

$requiredPaths = @(
  @{ Path = 'agent-assets'; Kind = 'Directory' },
  @{ Path = 'agent-assets\README.md'; Kind = 'File' },
  @{ Path = 'agent-assets\FEATURE.md'; Kind = 'File' },
  @{ Path = 'agent-assets\claude-plugin-directory.config.json'; Kind = 'File' },
  @{ Path = 'agent-assets\claude-plugin-directory\plugins'; Kind = 'Directory' },
  @{ Path = 'agent-assets\frontend\.codex-plugin\plugin.json'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend\.claude-plugin\plugin.json'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend\FEATURE.md'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend\skills\frontend-agent\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend\skills\frontend-agent\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend\skills\design-system-steward\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend\skills\design-system-steward\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend\skills\design-system-steward\references\design-md-template.md'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend\skills\frontend-error-ux\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend\skills\frontend-error-ux\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend\skills\frontend-agent\references\frontend-architecture.md'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend-design-plugin\.claude-plugin\plugin.json'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend-design-plugin\README.md'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend-design-plugin\LICENSE'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend-design-plugin\skills\frontend-design\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\frontend-design-plugin\skills\frontend-design\PROJECT_EXTENSION.md'; Kind = 'File' },
  @{ Path = 'agent-assets\project-documentation-wiki\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\project-documentation-wiki\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\project-documentation-wiki\scripts\init_project_wiki.py'; Kind = 'File' },
  @{ Path = 'agent-assets\project-documentation-wiki\references\llm-wiki-pattern.md'; Kind = 'File' },
  @{ Path = 'agent-assets\prompt-refiner\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\prompt-refiner\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\ui-ux-pro-max\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\ui-ux-pro-max\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\ui-ux-pro-max\scripts\search.py'; Kind = 'File' },
  @{ Path = 'agent-assets\ui-ux-pro-max\scripts\core.py'; Kind = 'File' },
  @{ Path = 'agent-assets\ui-ux-pro-max\data\styles.csv'; Kind = 'File' },
  @{ Path = 'agent-assets\ui-ux-pro-max\data\colors.csv'; Kind = 'File' },
  @{ Path = 'agent-assets\code-reviewer\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\code-reviewer\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\code-reviewer\rules\security-sql-injection.md'; Kind = 'File' },
  @{ Path = 'agent-assets\code-reviewer\rules\performance-n-plus-one.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend-patterns\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend-patterns\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\.codex-plugin\plugin.json'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\.claude-plugin\plugin.json'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\FEATURE.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\references\skillsmp-sources.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\references\backend-quality-checklist.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-engineering\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-engineering\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-api-contracts\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-api-contracts\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-data-persistence\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-data-persistence\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-security-auth\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-security-auth\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-reliability-observability\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-reliability-observability\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-performance-scaling\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-performance-scaling\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-framework-patterns\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-framework-patterns\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-code-review\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-code-review\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-golang\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-golang\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-fastapi\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-fastapi\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-django\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\backend\skills\backend-django\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\code-review-graph'; Kind = 'Directory' },
  @{ Path = 'agent-assets\superpowers\.codex-plugin\plugin.json'; Kind = 'File' },
  @{ Path = 'agent-assets\superpowers\README.md'; Kind = 'File' },
  @{ Path = 'agent-assets\superpowers\LICENSE'; Kind = 'File' },
  @{ Path = 'agent-assets\superpowers\assets\superpowers-small.svg'; Kind = 'File' },
  @{ Path = 'agent-assets\react-19-frontend-agent\.codex-plugin\plugin.json'; Kind = 'File' },
  @{ Path = 'agent-assets\react-19-frontend-agent\.claude-plugin\plugin.json'; Kind = 'File' },
  @{ Path = 'agent-assets\react-19-frontend-agent\FEATURE.md'; Kind = 'File' },
  @{ Path = 'agent-assets\react-19-frontend-agent\skills\react-19-frontend-agent\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\react-19-frontend-agent\skills\react-19-frontend-agent\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\react-19-frontend-agent\skills\react-19-patterns\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\react-19-frontend-agent\skills\react-19-patterns\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\react-19-frontend-agent\skills\nextjs-app-router-practices\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\react-19-frontend-agent\skills\nextjs-app-router-practices\agents\openai.yaml'; Kind = 'File' },
  @{ Path = 'agent-assets\react-19-frontend-agent\skills\typescript-react-routing\SKILL.md'; Kind = 'File' },
  @{ Path = 'agent-assets\react-19-frontend-agent\skills\typescript-react-routing\agents\openai.yaml'; Kind = 'File' }
)

foreach ($entry in $requiredPaths) {
  Assert-PathExists -RelativePath $entry.Path -Kind $entry.Kind
}

Assert-ClaudePluginDirectoryCatalog -RelativePath 'agent-assets\claude-plugin-directory.config.json'
Assert-ClaudePluginDirectoryPackages -CatalogRelativePath 'agent-assets\claude-plugin-directory.config.json' -PackagesRelativePath 'agent-assets\claude-plugin-directory\plugins'
Assert-CodeReviewGraphBundle -RelativePath 'agent-assets\code-review-graph'

$expectedSuperpowerSkills = @(
  'brainstorming',
  'dispatching-parallel-agents',
  'executing-plans',
  'finishing-a-development-branch',
  'receiving-code-review',
  'requesting-code-review',
  'subagent-driven-development',
  'systematic-debugging',
  'test-driven-development',
  'using-git-worktrees',
  'using-superpowers',
  'verification-before-completion',
  'writing-plans',
  'writing-skills'
)

foreach ($skillName in $expectedSuperpowerSkills) {
  Assert-PathExists -RelativePath "agent-assets\superpowers\skills\$skillName\SKILL.md" -Kind 'File'
  Assert-PathExists -RelativePath "agent-assets\superpowers\skills\$skillName\agents\openai.yaml" -Kind 'File'
}

foreach ($oldFolder in @('frontend', 'frontend-design-plugin', 'react-19-frontend-agent')) {
  Assert-OldRootFolderMoved -RelativePath $oldFolder
}

$pluginManifests = @(
  'agent-assets\frontend\.codex-plugin\plugin.json',
  'agent-assets\frontend\.claude-plugin\plugin.json',
  'agent-assets\frontend-design-plugin\.claude-plugin\plugin.json',
  'agent-assets\backend\.codex-plugin\plugin.json',
  'agent-assets\backend\.claude-plugin\plugin.json',
  'agent-assets\superpowers\.codex-plugin\plugin.json',
  'agent-assets\react-19-frontend-agent\.codex-plugin\plugin.json',
  'agent-assets\react-19-frontend-agent\.claude-plugin\plugin.json'
)

foreach ($manifestPath in $pluginManifests) {
  $manifest = Read-JsonFile -RelativePath $manifestPath
  if (-not $manifest.name) {
    throw "Plugin manifest is missing a name: $manifestPath"
  }
}

$skillFiles = Get-ChildItem -LiteralPath (Join-Path $ProjectRoot 'agent-assets') -Recurse -Filter 'SKILL.md'
$agentFiles = Get-ChildItem -LiteralPath (Join-Path $ProjectRoot 'agent-assets') -Recurse -Filter 'openai.yaml'
$referenceFiles = Get-ChildItem -LiteralPath (Join-Path $ProjectRoot 'agent-assets') -Recurse -File |
  Where-Object { $_.FullName -match '\\references\\' -or $_.Name -match '(?i)rule|checklist|governance|extension' }

if ($skillFiles.Count -lt 45) {
  throw "Expected at least 45 skill files, found $($skillFiles.Count)"
}

if ($agentFiles.Count -lt 37) {
  throw "Expected at least 37 agent files, found $($agentFiles.Count)"
}

if ($referenceFiles.Count -lt 20) {
  throw "Expected at least 20 reference/rule files, found $($referenceFiles.Count)"
}

Write-Host "agent-assets verification passed."
Write-Host "Skills: $($skillFiles.Count)"
Write-Host "Agents: $($agentFiles.Count)"
Write-Host "Reference/rule files: $($referenceFiles.Count)"
