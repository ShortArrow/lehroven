# LehrOven

```bash
"████    ████    ██" █    █▀▀ █  █ █▀▀█  █▀▀▀█ ▀█ █▀ █▀▀ █▀▀▄ "████    ████    ██"
"██    ████    ████" █    █▀▀ █▀▀█ █▄▄▀  █   █  █▄█  █▀▀ █  █ "██    ████    ████"
"████    ████    ██" █▄▄█ █▄▄ █  █ █ ▀█  █▄▄▄█   █   █▄▄ █  █ "████    ████    ██"
```

This is a toolkit for automatically inspecting Windows settings.

![PowerShell](https://img.shields.io/github/v/release/Powershell/Powershell?label=PowerShell) ![Pester](https://img.shields.io/github/v/release/pester/Pester?label=Pester)

## Name

>In the manufacture of glass, a lehr oven is a long kiln with an end-to-end temperature gradient, which is used for annealing newly made glass objects that are transported through the temperature gradient either on rollers or on a conveyor belt. The annealing renders glass into a stronger material with fewer internal stresses, and with a lower probability of breaking.

The window is made of multiple panes of glass. Annealing is a part of the process of making the glass, and is the process used to make the shape of the glass precise. This annealing is done by moving the glass in a long kiln. This kiln is the origin of the project name.

## Words

- Forming Machine
  - This file defines functions that encapsulate Windows settings.
- Testing Machine
  - forming machine This is a test file with one-to-one correspondence.

## Usage

First, Install dependencies.

```powershell
Install-Module Pester -Force
```

Next, Run Pester.

```powershell
git clone "https://github.com/ShortArrow/lehroven.git"
cd lehroven
Invoke-Pester
```

## Template

If you want add new forming machine and testing machine pair, run as follow.

```powershell
pwsh -f ".\bin\New-FormingMachine.ps1"
```

This will create a template. Rewrite the template.

## Dependencies

![alt](https://img.shields.io/github/v/release/Powershell/Powershell?label=PowerShell)

## Thanks

- Contributors of [@pester](https://github.com/pester)
- Contributors of [@PowerShell](https://github.com/PowerShell)
