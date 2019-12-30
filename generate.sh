# remove SFDX spinner
export FORCE_SPINNER_DELAY=
export FORCE_SHOW_SPINNER=

# create the commands-list.json file
sfdx force:doc:commands:list --json | jq -r .result > commands-list.json
sfdx force:doc:commands:display --json | jq '.result[] | select((.command) != null)' > commands-display.json

completion=""
completion+="#!/usr/bin/env bash"
completion+="\n"
completion+="\n# DESCRIPTION: Bash completion script for the Salesforce CLI"
completion+="\n# AUTHOR: Wade Wegner (@WadeWegner)"
completion+="\n# REPO: https://github.com/wadewegner/salesforce-cli-bash-completion"
completion+="\n# LICENSE: https://github.com/wadewegner/salesforce-cli-bash-completion/blob/master/LICENSE"
completion+="\n"

completion+="\nif ! type __ltrim_colon_completions >/dev/null 2>&1; then"
completion+="\n  #   Copyright © 2006-2008, Ian Macdonald <ian@caliban.org>"
completion+="\n  #             © 2009-2017, Bash Completion Maintainers"
completion+="\n  __ltrim_colon_completions() {"
completion+="\n      # If word-to-complete contains a colon,"
completion+="\n      # and bash-version < 4,"
completion+="\n      # or bash-version >= 4 and COMP_WORDBREAKS contains a colon"
completion+="\n      if [["
completion+="\n          \"\$1\" == *:* && ("
completion+="\n              \${BASH_VERSINFO[0]} -lt 4 ||"
completion+="\n              (\${BASH_VERSINFO[0]} -ge 4 && \"\$COMP_WORDBREAKS\" == *:*)"
completion+="\n          )"
completion+="\n      ]]; then"
completion+="\n          # Remove colon-word prefix from COMPREPLY items"
completion+="\n          local colon_word=\${1%\${1##*:}}"
completion+="\n          local i=\${#COMPREPLY[*]}"
completion+="\n          while [ \$((--i)) -ge 0 ]; do"
completion+="\n              COMPREPLY[\$i]=\${COMPREPLY[\$i]#\"\$colon_word\"}"
completion+="\n          done"
completion+="\n      fi"
completion+="\n  }"
completion+="\nfi"
completion+="\n"
completion+="\n_sfdx()"
completion+="\n{"
completion+="\n    local cur"
completion+="\n    local prev"
completion+="\n"
completion+="\n    _get_comp_words_by_ref -n : cur prev"
completion+="\n"
completion+="\n    local -a words=("
# generate list of commands
while read name
do
  completion+="\n        $name \\ "
done <<< "$(jq -r 'to_entries[] | "\(.value.name)"' commands-list.json)"

completion+="\n        plugins:install \\ "
completion+="\n        plugins:link \\ "
completion+="\n        plugins:install \\ "
completion+="\n        plugins:uninstall \\ "
completion+="\n        plugins:update \\ "
completion+="\n        update"

completion+="\n    )"
completion+="\n"
completion+="\n    case \"\$prev\" in"
completion+="\n    sfdx)"
completion+="\n        COMPREPLY=( \$(compgen -W \"\${words[*]}\" -- \$cur))"
completion+="\n        __ltrim_colon_completions \"\$cur\""
completion+="\n        ;;"
completion+="\n    *)"
completion+="\n        # return to normal completion"
completion+="\n        COMPREPLY=()"
completion+="\n        ;;"
completion+="\n    esac"
completion+="\n"
completion+="\n    return 0"
completion+="\n}"
completion+="\n"
completion+="\ncomplete -o default -F _sfdx sfdx"

echo "$completion" > sfdx.bash