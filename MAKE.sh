clear

#directory to store build/compiled files
buildDir=../untracked/build

#directory for source files
sourceDir=source

#make build directory if it doesn't exist
mkdir -p -v $buildDir


t=0.25
# -g = debug, -Os = Optimize Size
Compile=(avr-gcc -Wall -g -Os -I "includes/" -mmcu=atmega1280 -c -o)
Link=(avr-gcc -Wall -g -mmcu=atmega1280 -o)
IHex=(avr-objcopy -j .text -j .data -O ihex)


echo -e ">> COMPILE: "${Compile[@]}" "$buildDir"/sd_test.o " $sourceDir"/sd_test.c"
"${Compile[@]}" $buildDir/sd_test.o $sourceDir/sd_test.c
status=$?
sleep $t
if [ $status -gt 0 ]
then
    echo -e "error compiling SD_TEST.C"
    echo -e "program exiting with code $status"
    exit $status
else
    echo -e "Compiling SD_TEST.C successful"
fi



echo -e "\n\r>> COMPILE: "${Compile[@]}" "$buildDir"/sd_spi_base.o" $sourceDir"/sd_spi_base.c"
"${Compile[@]}" $buildDir/sd_spi_base.o $sourceDir/sd_spi_base.c
status=$?
sleep $t
if [ $status -gt 0 ]
then
    echo -e "error compiling SD_SPI_BASE.C"
    echo -e "program exiting with code $status"
    exit $status
else
    echo -e "Compiling SD_SPI_BASE.C successful"
fi


echo -e "\n\r>> COMPILE: "${Compile[@]}" "$buildDir"/sd_spi_data_access.o" $sourceDir"/sd_spi_data_access.c"
"${Compile[@]}" $buildDir/sd_spi_data_access.o $sourceDir/sd_spi_data_access.c
status=$?
sleep $t
if [ $status -gt 0 ]
then
    echo -e "error compiling sd_spi_data_access.C"
    echo -e "program exiting with code $status"
    exit $status
else
    echo -e "Compiling SD_SPI_DATA_ACCESS.C successful"
fi


echo -e "\n\r>> COMPILE: "${Compile[@]}" "$buildDir"/sd_spi_misc.o" $sourceDir"/sd_spi_misc.c"
"${Compile[@]}" $buildDir/sd_spi_misc.o $sourceDir/sd_spi_misc.c
status=$?
sleep $t
if [ $status -gt 0 ]
then
    echo -e "error compiling sd_spi_misc.c"
    echo -e "program exiting with code $status"
    exit $status
else
    echo -e "Compiling SD_SPI_MISC.C successful"
fi


echo -e "\n\r>> COMPILE: "${Compile[@]}" "$buildDir"/spi.o" $sourceDir"/spi.c"
"${Compile[@]}" $buildDir/spi.o $sourceDir/spi.c
status=$?
sleep $t
if [ $status -gt 0 ]
then
    echo -e "error compiling spi.c"
    echo -e "program exiting with code $status"
    exit $status
else
    echo -e "Compiling SPI.C successful"
fi


echo -e "\n\r>> COMPILE: "${Compile[@]}" "$buildDir"/usart.o" $sourceDir"/usart.c"
"${Compile[@]}" $buildDir/usart.o $sourceDir/usart.c
status=$?
sleep $t
if [ $status -gt 0 ]
then
    echo -e "error compiling usart.c"
    echo -e "program exiting with code $status"
    exit $status
else
    echo -e "Compiling USART.C successful"
fi


echo -e "\n\r>> COMPILE: "${Compile[@]}" "$buildDir"/prints.o" $sourceDir"/prints.c"
"${Compile[@]}" $buildDir/prints.o $sourceDir/prints.c
status=$?
sleep $t
if [ $status -gt 0 ]
then
    echo -e "error compiling prints.c"
    echo -e "program exiting with code $status"
    exit $status
else
    echo -e "Compiling PRINTS.C successful"
fi


echo -e "\n\r>> LINK: "${Link[@]}" "$buildDir"/sd_test.elf "$buildDir"/sd_test.o  "$buildDir"/spi.o "$buildDir"/sd_spi_base.o "$buildDir"/sd_spi_data_access.o "$buildDir"/sd_spi_misc.o "$buildDir"/usart.o "$buildDir"/prints.o"
"${Link[@]}" $buildDir/sd_test.elf $buildDir/sd_test.o $buildDir/spi.o $buildDir/sd_spi_base.o $buildDir/sd_spi_data_access.o $buildDir/sd_spi_misc.o $buildDir/usart.o $buildDir/prints.o
status=$?
sleep $t
if [ $status -gt 0 ]
then
    echo -e "error during linking"
    echo -e "program exiting with code $status"
    exit $status
else
    echo -e "Linking successful. Output in SD_TEST.ELF"
fi



echo -e "\n\r>> GENERATE INTEL HEX File: "${IHex[@]}" "$buildDir"/sd_test.elf "$buildDir"/sd_test.hex"
"${IHex[@]}" $buildDir/sd_test.elf $buildDir/sd_test.hex
status=$?
sleep $t
if [ $status -gt 0 ]
then
    echo -e "error generating HEX file"
    echo -e "program exiting with code $status"
    exit $status
else
    echo -e "HEX file successfully generated. Output in SD_TEST.HEX"
fi



echo -e "\n\r>> DOWNLOAD HEX FILE TO AVR"
echo "avrdude -p atmega1280 -c dragon_jtag -U flash:w:sd_test.hex:i -P usb"
avrdude -p atmega1280 -c dragon_jtag -U flash:w:$buildDir/sd_test.hex:i -P usb
status=$?
sleep $t
if [ $status -gt 0 ]
then
    echo -e "error during download of HEX file to AVR"
    echo -e "program exiting with code $status"
    exit $status
else
    echo -e "Program successfully downloaded to AVR"
fi
