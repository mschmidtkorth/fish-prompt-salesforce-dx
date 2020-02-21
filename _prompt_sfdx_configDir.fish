function _prompt_sfdx_configDir \
    -d 'Get root project folder of current project.'
    if string match -q -r 'force-app' $PWD # If $PWD contains force-app, we are in a subdirectory
        set -g configDir (string replace -r 'force-app.*' '' -- $PWD)
        # echo (string replace -r 'force-app.*' '' -- $PWD)
    else
        set -g configDir $PWD
		# echo $PWD
    end
end