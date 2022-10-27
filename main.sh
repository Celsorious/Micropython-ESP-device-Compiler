# MICROPYTHON COMPILER AND SERIAL PORT DATA READER #
# NECESSARY INSTALL AMPY AND SCREEN #

# FILES #
source functions_MICROPYTHON.sh

# GLOBAL VARIABLES #
continue_program=True

# MAIN PROGRAM
established_communication

while [ $continue_program == True ]
do
    run_options
done




