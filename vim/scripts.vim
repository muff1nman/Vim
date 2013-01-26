" Autodetect scripts that have no filetype extension
if did_filetype()	" filetype already set..
    finish		" ..don't do these checks
endif
if getline(1) =~ '^#!.*\<bash\>'
    setfiletype sh
elseif getline(1) =~? '\<python\>'
    setfiletype py
endif
