#!/bin/bash

myIP=$(bash myIP.bash)

# Todo-1: Help menu function
function helpMenu(){
    echo ""
    echo "Usage: bash networkchecker.bash -[n|s] [internal|external]"
    echo ""
    echo "Options:"
    echo "  -n [internal|external]   Use nmap to scan ports"
    echo "  -s [internal|external]   Use ss to list listening ports"
    echo ""
    echo "Arguments:"
    echo "  internal    Scan localhost (127.0.0.1)"
    echo "  external    Scan network IP ($myIP)"
    echo ""
    echo "Examples:"
    echo "  bash networkchecker.bash -n internal"
    echo "  bash networkchecker.bash -n external"
    echo "  bash networkchecker.bash -s internal"
    echo "  bash networkchecker.bash -s external"
    echo ""
    exit 1
}

# Return ports that are serving to the network
function ExternalNmap(){
    rex=$(nmap "${myIP}" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}')
    echo "Open ports on network ($myIP):"
    echo "$rex"
}

# Return ports that are serving to localhost
function InternalNmap(){
    rin=$(nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}')
    echo "Open ports on localhost:"
    echo "$rin"
}

# Only IPv4 ports listening from network
function ExternalListeningPorts(){
    # Todo-2: ss listing ports listening from network (non-localhost)
    elpo=$(ss -ltpn | awk -F"[[:space:]:(),]+" '/0\.0\.0\.0/ {print $5,$9}' | tr -d "\"")
    echo "Ports listening from network ($myIP):"
    echo "$elpo"
}

# Only IPv4 ports listening from localhost
function InternalListeningPorts(){
    ilpo=$(ss -ltpn | awk -F"[[:space:]:(),]+" '/127.0.0./ {print $5,$9}' | tr -d "\"")
    echo "Ports listening on localhost:"
    echo "$ilpo"
}

# Todo-3: If not exactly 2 arguments, print helpmenu
if [[ $# -ne 2 ]]; then
    helpMenu
fi

# Todo-4: getopts to accept -n and -s with internal/external arguments
while getopts ":n:s:" option; do
    case $option in
        n)
            if [[ "$OPTARG" == "internal" ]]; then
                InternalNmap
            elif [[ "$OPTARG" == "external" ]]; then
                ExternalNmap
            else
                echo "Invalid argument: $OPTARG"
                helpMenu
            fi
            ;;
        s)
            if [[ "$OPTARG" == "internal" ]]; then
                InternalListeningPorts
            elif [[ "$OPTARG" == "external" ]]; then
                ExternalListeningPorts
            else
                echo "Invalid argument: $OPTARG"
                helpMenu
            fi
            ;;
        *)
            echo "Invalid option: -$OPTARG"
            helpMenu
            ;;
    esac
done