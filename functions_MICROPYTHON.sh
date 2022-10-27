#!/bin/bash

# IMPORTED FILES #
source dialog.sh
source port_config.sh

# FUNCTIONS #

# ANIMATION OF PROGRESS BAR #
function progress_bar(){
    for i in $(seq 1 100)
    do
        sleep 0.01 
        echo $i
    done | dialog --title "$TITLE_PROGRESSBAR" --gauge "$OUTPUT_PROGRESSBAR" 6 60 0
}

# CHECK USB CONNECTION #
function dialog_USB(){
    dialog --clear --ok-label "$OK_LABEL" --title "$TITLE_DIALOG_USB" --msgbox "$OUTPUT_DIALOG_USB" $HEIGHT $WIDTH
}

function dialog_error_USB(){
    dialog --clear --ok-label "$OK_LABEL" --title "$TITLE_ERROR_USB" --msgbox "$OUTPUT_ERROR_USB" $HEIGHT $WIDTH
}

function read_USB_port(){
    ls $USB_port > /dev/null 2>&1
    return_ls=$?
    echo $return_ls
}

function USB_port_exist(){
    dialog_USB
    info_connection=$(read_USB_port) 

    while [ $info_connection == $ERROR_CONNECTION ]
    do
        dialog_error_USB
        info_connection=$(read_USB_port)
    done
}

# ALLOW PERMISSIONS TO THE USB PORT #
function enter_password(){
    PASSWORD=$(dialog --clear --title "$TITLE_PASSWORD" --ok-label "$OK_LABEL" --nocancel --insecure --passwordbox "$OUTPUT_GET_PASSWORD" $HEIGHT $WIDTH 3>&1 1>&2 2>&3 3>&-)
    echo $PASSWORD

}

function dialog_error_permissions_USB(){
    dialog --clear --ok-label "$OK_LABEL" --title "$TITLE_ERROR_PERMISSIONS_USB" --msgbox "$OUTPUT_ERROR_PERMISSIONS_USB" $HEIGHT $WIDTH
}

function dialog_connection_established(){
    dialog   --ok-label "$OK_LABEL" --msgbox "$OUTPUT_CONNECTION_ESTABLISHED" $HEIGHT $WIDTH
}

function allow_permission_USB(){
    user_PASSWORD=$(enter_password)
    sudo -S <<< $user_PASSWORD chmod 777 $USB_port > /dev/null 2>&1  
    return_chmod=$?

    echo $return_chmod

}

function check_permissions_OK(){

    info_permissions_USB=$(allow_permission_USB)

    while [ $info_permissions_USB == $ERROR_COMUNNICATION ]
    do
        dialog_error_permissions_USB
        info_permissions_USB=$(allow_permission_USB)
    done

    progress_bar
    dialog_connection_established

}

# DIALOG DISPLAY MENU #
function dialog_menu_options(){
    TO_RUN=$(dialog --title "${TITLE_MENU}" --backtitle "$SUBTITLE_MENU" --cancel-label "$CANCEL_LABEL" --menu "${OUTPUT_MENU}" 0 0 8 \
    "${TITLE_OPTIONS[0]}" "${OUTPUT_OPTIONS[0]}" \
    "${TITLE_OPTIONS[1]}" "${OUTPUT_OPTIONS[1]}" \
    "${TITLE_OPTIONS[2]}" "${OUTPUT_OPTIONS[2]}" \
    "${TITLE_OPTIONS[3]}" "${OUTPUT_OPTIONS[3]}" \
    "${TITLE_OPTIONS[4]}" "${OUTPUT_OPTIONS[4]}" \
    "${TITLE_OPTIONS[5]}" "${OUTPUT_OPTIONS[5]}" \
    "${TITLE_OPTIONS[6]}" "${OUTPUT_OPTIONS[6]}" 3>&1 1>&2 2>&3)

    echo $TO_RUN
}

# MENU FUNCTIONS #
function exit_program(){
    continue_program=False
    clear
    exit
}

# UPLOAD PROGRAM #
function dialog_upload_program(){
   NAME_FILE=$(dialog --title "$TITLE_UPLOAD_FILE" --clear --nocancel --inputbox "$OUTPUT_UPLOAD_FILE" $HEIGHT $WIDTH 3>&1 1>&2 2>&3 3>&-) 
   echo $NAME_FILE
}

function dialog_error_upload_program(){
    dialog --clear --title "$ERROR_TITLE_UPLOAD_FILE" --msgbox "$file_upload not exists or is empty." $HEIGHT $WIDTH
}

function dialog_upload_completed(){
    dialog --clear --ok-label "$OK_LABEL" --msgbox "$OUTPUT_UPLOAD_COMPLETED" $HEIGHT $WIDTH
}

function upload_program(){
    file_upload=$(dialog_upload_program)
    while [ ! -e "$file_upload" ]
    do
       dialog_error_upload_program
       file_upload=$(dialog_upload_program)
    done
    while ampy -p $USB_port put $file_upload; 
    do
        progress_bar
        break
    done
    dialog_upload_completed
}

# RUN FILE AND PRINT ITS OUTPUT #
function dialog_run_file(){
    NAME_FILE=$(dialog --title "$TITLE_RUN_FILE" --clear --nocancel --inputbox "$OUTPUT_RUN_FILE" $HEIGHT $WIDTH 3>&1 1>&2 2>&3 3>&-) 
    echo $NAME_FILE
}

function run_file(){
    file_run=$(dialog_run_file)
    return_file=$(ampy -p $USB_port run $file_run)
    echo $return_file
}

function dialog_return_file(){
    return_file=$(run_file)
    dialog --clear --title "$TITLE_RUN" --msgbox "$return_file" $HEIGHT $WIDTH
}

# DATA SERIAL PORT VIEW #
function view_serial_port(){
    screen $USB_port $BAUDRATE
}

# REMOVE FILE FROM ESP DEVICE #
function dialog_remove_file(){
    NAME_FILE=$(dialog --title "$TITLE_REMOVE_FILE" --clear --nocancel --inputbox "$OUTPUT_REMOVE_FILE" $HEIGHT $WIDTH 3>&1 1>&2 2>&3 3>&-) 
    echo $NAME_FILE
}

function dialog_remove_completed(){
    dialog --clear --ok-label "$OK_LABEL" --msgbox "$OUTPUT_REMOVE_COMPLETED" $HEIGHT $WIDTH
}

function remove_file(){
    file_remove=$(dialog_remove_file)
    while ampy -p $USB_port rm $file_remove;
    do
        progress_bar
        break
    done
    dialog_remove_completed
}

# RESET ESP DEVICE #
function dialog_reset_completed(){
    dialog --clear --ok-label "$OK_LABEL" --msgbox "$OUTPUT_RESET_COMPLETED" $HEIGHT $WIDTH
}

function reset_board(){
    ampy -p $USB_port reset
    return_reset=$?
    if [ $return_reset == $RETURN_RESET_OK ];
    then
        dialog_reset_completed
    fi
}

# SEE FILES IN ESP DEVICE #
function ls_files(){
    files=$(ampy -p $USB_port ls 2>/dev/null)
    echo $files
}

function dialog_return_ls_files(){
    files_ESP=$(ls_files)
    dialog --clear --title "$TITLE_LS_FILES" --msgbox "$files_ESP" $HEIGHT $WIDTH
}

function established_communication(){
    USB_port_exist
    check_permissions_OK
}

# RUN MENU OPTIONS #
function run_options(){
    OPTION=$(dialog_menu_options)
    case $OPTION in
        $EXIT_SCRIPT) exit_program;;
        $ESC) exit_program;;
        ${TITLE_OPTIONS[0]}) upload_program;;
        ${TITLE_OPTIONS[1]}) dialog_return_file;;
        ${TITLE_OPTIONS[2]}) view_serial_port;;
        ${TITLE_OPTIONS[3]}) remove_file;;
        ${TITLE_OPTIONS[4]}) dialog_return_ls_files;;
        ${TITLE_OPTIONS[5]}) reset_board;;
        ${TITLE_OPTIONS[6]}) established_communication;;
    esac
}

