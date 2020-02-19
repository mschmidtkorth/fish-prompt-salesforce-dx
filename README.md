# Salesforce DX (SFDX) Status for fish Pure Prompt
Adds the status of Salesforce DX projects to your fish prompt, based on [Pure Prompt](https://github.com/rafaelrinaldi/pure).

## Requirements

- [fish](https://github.com/fish-shell/fish-shell)
- [Pure Prompt](https://github.com/rafaelrinaldi/pure)

## Installation

- Copy `_pure_prompt_sfdx.fish` to `~/.config/fish/functions/`
- Copy `_pure_prompt_first_line.fish` to `~/.config/fish/functions/` (replace existing file)

**Note** You may also modify `_pure_prompt_first_line.fish` instead of replacing it. `_pure_prompt_first_line.fish` is overwritten with any update of Pure Prompt or updates via Fisher and needs to be restored.

## Usage

- Simply open any directory that contains a `.force` folder and watch your prompt change

![Example prompt](Example.png)

**Note** The iTerm2 status bar component at the bottom can be found [here](https://github.com/mschmidtkorth/iTerm-salesforce-dx).

## How to Contribute

Please see the [contribution guidelines](CONTRIBUTING.md).

## Changelog

- **0.1.0** (2020-02-19)
  - Initial release