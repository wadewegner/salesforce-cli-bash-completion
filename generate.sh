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
completion+="\n    local words"
completion+="\n"
completion+="\n    cur=\"\${COMP_WORDS[COMP_CWORD]}\""
completion+="\n    words='force:alias:list force:alias:set force:apex:class:create force:apex:execute force:apex:log:get force:apex:log:list force:apex:test:report force:apex:test:run force:apex:trigger:create force:auth:jwt:grant force:auth:sfdxurl:store force:auth:web:login force:config:get force:config:list force:config:set force:data:bulk:delete force:data:bulk:status force:data:bulk:upsert force:data:record:create force:data:record:delete force:data:record:get force:data:record:update force:data:soql:query force:data:tree:export force:data:tree:import force:doc:commands:display force:doc:commands:list force:lightning:app:create force:lightning:component:create force:lightning:event:create force:lightning:interface:create force:lightning:lint force:lightning:test:create force:lightning:test:install force:lightning:test:run force:limits:api:display force:mdapi:convert force:mdapi:deploy force:mdapi:deploy:report force:mdapi:retrieve force:mdapi:retrieve:report force:org:create force:org:delete force:org:display force:org:list force:org:open force:org:shape:create force:org:shape:delete force:org:shape:list force:package1:version:create force:package1:version:create:get force:package1:version:display force:package1:version:list force:package2:create force:package2:list force:package2:update force:package2:version:create force:package2:version:create:get force:package2:version:create:list force:package2:version:get force:package2:version:list force:package2:version:update force:package:install force:package:install:get force:package:installed:list force:package:uninstall force:package:uninstall:get force:project:create force:project:upgrade force:schema:sobject:describe force:schema:sobject:list force:source:convert force:source:open force:source:pull force:source:push force:source:status force:user:create force:user:display force:user:list force:user:password:generate force:user:permset:assign force:visualforce:component:create force:visualforce:page:create'"
completion+="\n"
completion+="\n    COMPREPLY=( \$(compgen -W '\$words'  -- \$cur))"
completion+="\n    __ltrim_colon_completions \"\$cur\""
completion+="\n"
completion+="\n    return 0"
completion+="\n}"
completion+="\n"
completion+="\ncomplete -F _sfdx sfdx"

echo "$completion" > sfdx.bash