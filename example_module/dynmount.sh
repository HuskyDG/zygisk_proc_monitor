MODDIR="${0%/*}"

# API_VERSION = 1
STAGE="$1" # prepareEnterMntNs or EnterMntNs
PID="$2" # PID of app process
UID="$3" # UID of app process
PROC="$4" # Process name. Example: com.google.android.gms.unstable
USERID="$5" # USER ID of app
# API_VERSION = 2
# Enable ash standalone
# Enviroment variables: MAGISKTMP, API_VERSION

RUN_SCRIPT(){
    if [ "$STAGE" == "prepareEnterMntNs" ]; then
        prepareEnterMntNs
    elif [ "$STAGE" == "EnterMntNs" ]; then
        EnterMntNs
    fi
}

prepareEnterMntNs(){
    # script run before enter the mount name space of app process
    if [ "$API_VERSION" -lt 2 ]; then
	    exit 1
	fi

    if [ "$PROC" == "com.google.android.gms.unstable" ]; then
        exit 0
    fi

    #exit 0 # allow script to run in EnterMntNs stage
    exit 1 # close script and don't allow script to run in EnterMntNs stage
}


EnterMntNs(){
    # script run after enter the mount name space of app process and you allow this script to run in EnterMntNs stage

    mount -t tmpfs tmpfs /data/local/tmp

}

RUN_SCRIPT

