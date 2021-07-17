#!/usr/bin/bash

echo -e "  \033[1;33m\nSOLO PUEDES ENVIAR UN SMS CADA 24 HORAS\n"

echo -e "\033[1;32m  ESCRIBE EL NUMERO CON EL CODIGO DE TU PAIS\n"
read -p $'\033[1;33mNUMERO: \033[0m' numero

read -p $'\033[1;33mMENSAJE: \033[0m' mensaje
curl -X POST https://textbelt.com/text --data-urlencode phone="${numero}" --data-urlencode message="${mensaje}" -d key=textbelt > /dev/null 2>&1
if [[ $(echo $?) == "0" ]]; then
	echo -e "\n\033[1;33mEl mensaje se envio correctamente.\033[0m"
else
	echo -e "\n\033[1;31mOcurrio un error en el envio.\033[0m"
fi

echo ''
