function ctx
    if [ -z $argv[1] ]
        echo "Context to apply should be given."
        return
    end

    if type -q task
        task context $argv[1]
    end
    if type -q gcloud
        gcloud config configurations activate $argv[1]
    end
end

complete -c ctx -x -a 'home work'
