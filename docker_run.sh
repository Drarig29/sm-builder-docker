#!/bin/bash
cd /src
cp -rf /src/* /builder/
cd /builder

if grep -q "#include <json>" ./scripting/*.sp ; then
    echo "Reference to sm_json detected."
    echo "Installing sm_json..."
    git clone https://github.com/clugg/sm-json
    cp -r ./sm-json/addons/sourcemod/scripting/include/* ./addons/sourcemod/scripting/include
fi

if [ ! -f ./smbuild ]; then
    echo -e "\nThe smbuild file is missing."
    
    script_files=$(ls ./scripting/*.sp)
    main_file=${script_files[0]}
    plugin_name=$(basename $main_file .sp)

    echo -e "Creating one automatically for: $plugin_name\n"

    echo "Plugin(source='scripting/get5_eventapi.sp')"  >   ./smbuild
    echo "Package(name='get5_eventapi',"                >>  ./smbuild
    echo "    filegroups={"                             >>  ./smbuild
    echo "        '.': ['LICENSE', 'README.md'],"       >>  ./smbuild
    echo "    },"                                       >>  ./smbuild
    echo ")"                                            >>  ./smbuild

    cat ./smbuild
fi

echo -e "\nBuilding the plugin..."

smbuilder --flags='-E'
cp -rf /builder/builds/* /out/

echo -e "\nPlugin successfully build! 🎉"