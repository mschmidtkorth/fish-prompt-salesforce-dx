# Salesforce DX (SFDX) Status for fish
Adds the status of Salesforce DX projects to your fish prompt. Compatible with other prompts, e.g. Pure.

## Requirements

- [fish](https://github.com/fish-shell/fish-shell)

## Installation

- Copy `_prompt_sfdx.fish` to `~/.config/fish/functions/`
- Copy `fish_prompt.fish` to `~/.config/fish/functions/` (replace existing file, backup before)

**Note** You may also modify `fish_prompt.fish` instead of replacing it.

## Usage

- Simply open any directory that contains a `.force` folder and watch your prompt change

![Example prompt](Example.png)

**Note** The iTerm2 status bar component at the bottom can be found [here](https://github.com/mschmidtkorth/iTerm-salesforce-dx).

## How to Contribute

Please see the [contribution guidelines](CONTRIBUTING.md).

## Changelog

- **0.1.0** (2020-02-19)
  - Initial release