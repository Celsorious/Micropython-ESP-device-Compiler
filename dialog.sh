# DIALOG NCURSES MODIFICABLE PARAMETERS#

# ADJUST DIMENSIONAL SCREEN PARAMETERS #
HEIGHT=0
WIDTH=0

OK_LABEL="Continue"
CANCEL_LABEL="Exit"
HELP_LABEL="Help"
EXIT_SCRIPT=""
ESC=255

# WINDOW ENTER PASSWORD #
OUTPUT_GET_PASSWORD="Enter your password to allow permissions:"
TITLE_PASSWORD="Configuration"
TITLE_ERROR_PERMISSIONS_USB="Error configuration USB port:"
OUTPUT_ERROR_PERMISSIONS_USB="Password is incorrect or the USB is disconnected. Check and reenter the password."

# WINDOW READ CONNECTION #
OUTPUT_DIALOG_USB="Connect your ESP device to available USB port."
TITLE_DIALOG_USB="ESP device connection:"
OUTPUT_ERROR_USB="Connection is not established.Check the USB cable and make sure the power LED is on."
TITLE_ERROR_USB="Error connection:"

# WINDOW PROGRESS BAR #
TITLE_PROGRESSBAR="Progress:"
OUTPUT_PROGRESSBAR="Running..."

# WINDOW CONNECTION ESTABLISHED #
OUTPUT_CONNECTION_ESTABLISHED="Connection established."

# WINDOW MENU #
TITLE_MENU="Menu:"
SUBTITLE_MENU="MICROPYTHON COMPILER."
OUTPUT_MENU="Choose an option:"
TITLE_OPTIONS=("Upload" "Run" "Serial port" "Remove" "Ls files" "Reset" "Restart")
OUTPUT_OPTIONS=("Upload a file to ESP device." "Run a script and print its output." "View the data from serial port" "Remove a file from the ESP device" "See the files saved in the ESP device." "Soft reset to the ESP device." "Restart the process of communication")

# WINDOW UPLOAD PROGRAM #
TITLE_UPLOAD_FILE="Upload:"
OUTPUT_UPLOAD_FILE="Enter the name of the file to compile:"
ERROR_UPLOAD_FILE="$name_file_not_exists not exists or is empty."
ERROR_TITLE_UPLOAD_FILE="Error uploading the file:"
OUTPUT_UPLOAD_COMPLETED="Upload completed."

# WINDOW RUN PROGRAM #
TITLE_RUN_FILE="Run:"
OUTPUT_RUN_FILE="Enter the name of the file to run:"
TITLE_RUN="Output:"

# WINDOW REMOVE FILE#
TITLE_REMOVE_FILE="Remove:"
OUTPUT_REMOVE_FILE="Enter the name of the file to remove:"
OUTPUT_REMOVE_COMPLETED="Remove completed."

# WINDOW RESET #
OUTPUT_RESET_COMPLETED="Reset completed."

# WINDOW LS FILES #
TITLE_LS_FILES="Files:"



