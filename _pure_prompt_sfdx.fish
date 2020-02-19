# https://github.com/mschmidtkorth/fish-pure-prompt-salesforce-dx/tree
# Note: Is executed whenever prompt is redrawn, so for every command. Keep it performant.
function _pure_prompt_sfdx \
    -d 'Print sfdx scratch informations: Default alias and username, expiration date of default alias/username\'s org'

    set -g configDir (pure_prompt_sfdx_configDir)

    if test -e $configDir/sfdx-project.json # Is current dir a SFDX project (sub)directory?
        #------- Create global variables
        set -g theme_powerline_fonts no
        set -g aliasOrUsername (_pure_prompt_sfdx_aliasOrUsername)
        set -g usernameForAlias (_pure_prompt_sfdx_usernameForAlias)

        #------- Set prompt variables
        set -l sfdx_prompt_aliasOrUsername
        if test -n $aliasOrUsername
            set sfdx_prompt_aliasOrUsername $aliasOrUsername
        end

        set -l sfdx_prompt_username
        if test -n $usernameForAlias
            set sfdx_prompt_username $usernameForAlias
        end

        # set -l sfdx_prompt_expiration # Slows down execution...
        # if test -n $usernameForAlias
        #     set sfdx_prompt_expiration (_pure_prompt_sfdx_orgExpiration)
        # end

        #------- Generate prompt output
        if test -n $theme_powerline_fonts # TODO: Implement arrow segmentation using unicode glyphs
            set sfdx_prompt (set_color 489cdc)$right_arrow_glyph (set_color white -b 489cdc) \u2601 $sfdx_prompt_aliasOrUsername $sfdx_prompt_username (set_color 489cdc)$right_black_arrow_glyph #$sfdx_prompt_expiration
        else
            set sfdx_prompt (set_color white -b 489cdc) \uf01a $sfdx_prompt_aliasOrUsername $sfdx_prompt_username #$sfdx_prompt_expiration
            # TODO: MesloLGS NF (Nerd Font) makes the unicode characters appear tiny (eg Cloud)
        end
        echo $sfdx_prompt
    end
end

function _pure_prompt_sfdx_aliasOrUsername \
    -d 'Return default = current SFDX Alias or Username if present'
    if test -e $configDir/.sfdx/sfdx-config.json
        set configPath $configDir/.sfdx/sfdx-config.json
    else
        set configPath $HOME/.sfdx/sfdx-config.json
    end

    set -l has_sfdx_alias_username (command jq -r '.defaultusername|strings' $configPath 2>/dev/null) # Get "defaultusername" from JSON
    if test -n $has_sfdx_alias_username
        echo $has_sfdx_alias_username
    else
        echo false
    end
end

function _pure_prompt_sfdx_usernameForAlias \
    -d 'Returns Username (e.g. a@b.com) for given Alias (e.g. SFDC-1234)'
    if test -n $aliasOrUsername
        set aliasPath $HOME/.sfdx/alias.json
        echo (command jq --arg jq_aliasOrUsername $aliasOrUsername -r '.orgs[$jq_aliasOrUsername]|strings' $aliasPath 2>/dev/null)
    else
        echo false
    end
end

# NOTE: Has been disabled, as it slows down the prompt when cd'ing into a SFDX dir (and any follow up command) as :display takes >5 seconds to finish. fish does not support background functions.
function _pure_prompt_sfdx_orgExpiration \
    -d 'Returns expiration date of scratch org or sandbox org.'
    if test -n $aliasOrUsername
        echo (command sfdx force:org:display --targetusername=$aliasOrUsername --json 2>&1 | jq -r 'if .status == 1 then "error" elif .result.status == "Active" then .result.expirationDate elif .result.status == "Expired" then "expired" else "sbx" end' 2>/dev/null)
    else
        echo false
    end
end

function pure_prompt_sfdx_configDir \
    -d 'Get root project folder of current project.'
    if string match -q -r 'force-app' $PWD # If $PWD contains force-app, we are in a subdirectory
        echo (string replace -r 'force-app.*' '' -- $PWD)
    else
        echo $PWD
    end
end