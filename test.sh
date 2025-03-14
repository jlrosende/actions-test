#!/bin/bash
usage()
          {
            echo "Usage: alphabet -v | --version VERSION  
                                  -e | --env ENVIRONMENT 
                                  [ -l | --label {auto-approval,manual-approval} ]"
            exit 2
          }

          params=$(echo "$1" | sed 's/\/deploy-faas//')

          parsed_params=$(getopt -a -o "-v,-e,-l:" -l "version:,env:,label:" -- $params)

          if [ $? -ne 0 ]; then
              usage
          fi

          eval set -- "$parsed_params"

          echo $@

          while :
          do
            case "$1" in
              -v | --version)     
                echo "::set-output name=version::release/$2"; 
                shift 2 ;;
              -e | --env)         
                echo "::set-output name=env::environment/$2"; 
                shift 2 ;;
              -l | --label)
                if [[ $2 != "auto-approval" && $2 != "manual-approval" ]]; then
                  usage
                fi
                echo "::set-output name=label::$2"; 
                shift 2 ;;
              # -- means the end of the arguments; drop this, and break out of the while loop
              --) 
                shift; 
                break ;;
              # If invalid options were passed, then getopt should have reported an error,
              # which we checked as VALID_ARGUMENTS when getopt was called...
              *) echo "Unexpected option: $1 - this should not happen."
                usage ;;
            esac
          done


          asasasasa