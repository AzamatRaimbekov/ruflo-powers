param(
  [string]$CodexSkillsRoot = ''
)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($CodexSkillsRoot)) {
  if (-not [string]::IsNullOrWhiteSpace($env:CODEX_HOME)) {
    $CodexSkillsRoot = Join-Path $env:CODEX_HOME 'skills'
  } else {
    $CodexSkillsRoot = Join-Path $HOME '.codex\skills'
  }
}

function Assert-PathExists {
  param(
    [string]$Path,
    [string]$Kind = 'Any'
  )

  if ($Kind -eq 'Directory') {
    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
      throw "Missing directory: $Path"
    }
    return
  }

  if ($Kind -eq 'File') {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
      throw "Missing file: $Path"
    }
    return
  }

  if (-not (Test-Path -LiteralPath $Path)) {
    throw "Missing path: $Path"
  }
}

function Assert-FileContains {
  param(
    [string]$Path,
    [string]$Expected
  )

  $content = Get-Content -LiteralPath $Path -Raw
  if (-not $content.Contains($Expected)) {
    throw "Expected $Path to contain: $Expected"
  }
}

$skillRoot = Join-Path $CodexSkillsRoot 'prompt-refiner'
$skillFile = Join-Path $skillRoot 'SKILL.md'
$agentFile = Join-Path $skillRoot 'agents\openai.yaml'

Assert-PathExists -Path $skillRoot -Kind 'Directory'
Assert-PathExists -Path $skillFile -Kind 'File'
Assert-PathExists -Path $agentFile -Kind 'File'
Assert-FileContains -Path $skillFile -Expected 'name: prompt-refiner'
Assert-FileContains -Path $skillFile -Expected 'Refined Prompt'
Assert-FileContains -Path $agentFile -Expected 'Use $prompt-refiner'

Write-Host "global prompt-refiner install verification passed."
Write-Host "Skill: $skillRoot"
