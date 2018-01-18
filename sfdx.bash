#!/usr/bin/env bash

# DESCRIPTION: Bash completion script for the Salesforce CLI
# AUTHOR: Wade Wegner (@WadeWegner)
# REPO: https://github.com/wadewegner/salesforce-cli-bash-completion
# LICENSE: https://github.com/wadewegner/salesforce-cli-bash-completion/blob/master/LICENSE

if ! type __ltrim_colon_completions >/dev/null 2>&1; then
  #   Copyright © 2006-2008, Ian Macdonald <ian@caliban.org>
  #             © 2009-2017, Bash Completion Maintainers
  __ltrim_colon_completions() {
      # If word-to-complete contains a colon,
      # and bash-version < 4,
      # or bash-version >= 4 and COMP_WORDBREAKS contains a colon
      if [[
          "$1" == *:* && (
              ${BASH_VERSINFO[0]} -lt 4 ||
              (${BASH_VERSINFO[0]} -ge 4 && "$COMP_WORDBREAKS" == *:*)
          )
      ]]; then
          # Remove colon-word prefix from COMPREPLY items
          local colon_word=${1%${1##*:}}
          local i=${#COMPREPLY[*]}
          while [ $((--i)) -ge 0 ]; do
              COMPREPLY[$i]=${COMPREPLY[$i]#"$colon_word"}
          done
      fi
  }
fi

_sfdx()
{
    local cur
    local prev

    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    local -a words=(
        force:alias:list \ 
        force:alias:set \ 
        force:apex:class:create \ 
        force:apex:execute \ 
        force:apex:log:get \ 
        force:apex:log:list \ 
        force:apex:test:report \ 
        force:apex:test:run \ 
        force:apex:trigger:create \ 
        force:auth:jwt:grant \ 
        force:auth:sfdxurl:store \ 
        force:auth:web:login \ 
        force:config:get \ 
        force:config:list \ 
        force:config:set \ 
        force:data:bulk:delete \ 
        force:data:bulk:status \ 
        force:data:bulk:upsert \ 
        force:data:record:create \ 
        force:data:record:delete \ 
        force:data:record:get \ 
        force:data:record:update \ 
        force:data:soql:query \ 
        force:data:tree:export \ 
        force:data:tree:import \ 
        force:doc:commands:display \ 
        force:doc:commands:list \ 
        force:lightning:app:create \ 
        force:lightning:component:create \ 
        force:lightning:event:create \ 
        force:lightning:interface:create \ 
        force:lightning:lint \ 
        force:lightning:test:create \ 
        force:lightning:test:install \ 
        force:lightning:test:run \ 
        force:limits:api:display \ 
        force:mdapi:convert \ 
        force:mdapi:deploy \ 
        force:mdapi:deploy:report \ 
        force:mdapi:retrieve \ 
        force:mdapi:retrieve:report \ 
        force:org:create \ 
        force:org:delete \ 
        force:org:display \ 
        force:org:list \ 
        force:org:open \ 
        force:org:shape:create \ 
        force:org:shape:delete \ 
        force:org:shape:list \ 
        force:package1:version:create \ 
        force:package1:version:create:get \ 
        force:package1:version:display \ 
        force:package1:version:list \ 
        force:package2:create \ 
        force:package2:list \ 
        force:package2:update \ 
        force:package2:version:create \ 
        force:package2:version:create:get \ 
        force:package2:version:create:list \ 
        force:package2:version:get \ 
        force:package2:version:list \ 
        force:package2:version:update \ 
        force:package:install \ 
        force:package:install:get \ 
        force:package:installed:list \ 
        force:package:uninstall \ 
        force:package:uninstall:get \ 
        force:project:create \ 
        force:project:upgrade \ 
        force:schema:sobject:describe \ 
        force:schema:sobject:list \ 
        force:source:convert \ 
        force:source:open \ 
        force:source:pull \ 
        force:source:push \ 
        force:source:status \ 
        force:user:create \ 
        force:user:display \ 
        force:user:list \ 
        force:user:password:generate \ 
        force:user:permset:assign \ 
        force:visualforce:component:create \ 
        force:visualforce:page:create \ 
    )

    case "$prev" in
    sfdx)
        COMPREPLY=( $(compgen -W "${words[*]}" -- $cur))
        __ltrim_colon_completions "$cur"
        ;;
    *)
        COMPREPLY=($(compgen -f  -- "${COMP_WORDS[${COMP_CWORD}]}" ))

        for ((ff=0; ff<${#COMPREPLY[@]}; ff++)); do
            test -d "${COMPREPLY[$ff]}" && COMPREPLY[$ff]="${COMPREPLY[$ff]}/"
            test -f "${COMPREPLY[$ff]}" && COMPREPLY[$ff]="${COMPREPLY[$ff]} "
        done

        ;;
    esac

    return 0
}

complete -o bashdefault -o nospace  -F _sfdx sfdx