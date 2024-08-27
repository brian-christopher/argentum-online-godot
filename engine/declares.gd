extends RefCounted
class_name Declares 

const NUMSKILLS = 21;  
const MAXHECHI = 35;
const MAX_INVENTORY_SLOTS = 30; 
const MAX_INVENTORY_SLOTS_SERVER = 20
const NUMATRIBUTES = 5

const MAP_WIDTH = 100
const MAP_HEIGHT = 100
const TILE_SIZE = 32

const NUMCIUDADES = 5
const NUMCLASES = 16
const NUMRAZAS = 5

const bCabeza = 1
const bPiernaIzquierda = 2
const bPiernaDerecha = 3
const bBrazoDerecho = 4
const bBrazoIzquierdo = 5
const bTorso = 6

#MENSAJE_*  --> Mensajes de texto que se muestran en el cuadro de texto
const MENSAJE_CRIATURA_FALLA_GOLPE = "La criatura fallo el golpe!!!"
const MENSAJE_CRIATURA_MATADO = "La criatura te ha matado!!!"
const MENSAJE_RECHAZO_ATAQUE_ESCUDO = "Has rechazado el ataque con el escudo!!!"
const MENSAJE_USUARIO_RECHAZO_ATAQUE_ESCUDO  = "El usuario rechazo el ataque con su escudo!!!"
const MENSAJE_FALLADO_GOLPE = "Has fallado el golpe!!!"
const MENSAJE_SEGURO_ACTIVADO = ">>SEGURO ACTIVADO<<"
const MENSAJE_SEGURO_DESACTIVADO = ">>SEGURO DESACTIVADO<<"
const MENSAJE_PIERDE_NOBLEZA = "¡¡Has perdido puntaje de nobleza y ganado puntaje de criminalidad!! Si sigues ayudando a criminales te convertirás en uno de ellos y serás perseguido por las tropas de las ciudades."
const MENSAJE_USAR_MEDITANDO = "¡Estás meditando! Debes dejar de meditar para usar objetos."

const MENSAJE_SEGURO_RESU_ON = "SEGURO DE RESURRECCION ACTIVADO"
const MENSAJE_SEGURO_RESU_OFF = "SEGURO DE RESURRECCION DESACTIVADO"

const MENSAJE_GOLPE_CABEZA = "¡¡La criatura te ha pegado en la cabeza por "
const MENSAJE_GOLPE_BRAZO_IZQ = "¡¡La criatura te ha pegado el brazo izquierdo por "
const MENSAJE_GOLPE_BRAZO_DER = "¡¡La criatura te ha pegado el brazo derecho por "
const MENSAJE_GOLPE_PIERNA_IZQ = "¡¡La criatura te ha pegado la pierna izquierda por "
const MENSAJE_GOLPE_PIERNA_DER = "¡¡La criatura te ha pegado la pierna derecha por "
const MENSAJE_GOLPE_TORSO  = "¡¡La criatura te ha pegado en el torso por "

# MENSAJE_[12]: Aparecen antes y despues del valor de los mensajes anteriores (MENSAJE_GOLPE_*)
const MENSAJE_1 = "¡¡"
const MENSAJE_2 = "!!"

const MENSAJE_GOLPE_CRIATURA_1 = "¡¡Le has pegado a la criatura por "

const MENSAJE_ATAQUE_FALLO = " te ataco y fallo!!"

const MENSAJE_RECIVE_IMPACTO_CABEZA = " te ha pegado en la cabeza por "
const MENSAJE_RECIVE_IMPACTO_BRAZO_IZQ = " te ha pegado el brazo izquierdo por "
const MENSAJE_RECIVE_IMPACTO_BRAZO_DER = " te ha pegado el brazo derecho por "
const MENSAJE_RECIVE_IMPACTO_PIERNA_IZQ = " te ha pegado la pierna izquierda por "
const MENSAJE_RECIVE_IMPACTO_PIERNA_DER = " te ha pegado la pierna derecha por "
const MENSAJE_RECIVE_IMPACTO_TORSO = " te ha pegado en el torso por "

const MENSAJE_PRODUCE_IMPACTO_1 = "¡¡Le has pegado a "
const MENSAJE_PRODUCE_IMPACTO_CABEZA = " en la cabeza por "
const MENSAJE_PRODUCE_IMPACTO_BRAZO_IZQ = " en el brazo izquierdo por "
const MENSAJE_PRODUCE_IMPACTO_BRAZO_DER = " en el brazo derecho por "
const MENSAJE_PRODUCE_IMPACTO_PIERNA_IZQ = " en la pierna izquierda por "
const MENSAJE_PRODUCE_IMPACTO_PIERNA_DER = " en la pierna derecha por "
const MENSAJE_PRODUCE_IMPACTO_TORSO = " en el torso por "

const MENSAJE_TRABAJO_MAGIA = "Haz click sobre el objetivo..."
const MENSAJE_TRABAJO_PESCA = "Haz click sobre el sitio donde quieres pescar..."
const MENSAJE_TRABAJO_ROBAR = "Haz click sobre la victima..."
const MENSAJE_TRABAJO_TALAR = "Haz click sobre el árbol..."
const MENSAJE_TRABAJO_MINERIA = "Haz click sobre el yacimiento..."
const MENSAJE_TRABAJO_FUNDIRMETAL = "Haz click sobre la fragua..."
const MENSAJE_TRABAJO_PROYECTILES = "Haz click sobre la victima..."

const MENSAJE_ENTRAR_PARTY_1 = "Si deseas entrar en una party con "
const MENSAJE_ENTRAR_PARTY_2 = ", escribe /entrarparty"

const MENSAJE_NENE = "Cantidad de NPCs: "

const race_names = {
	Enums.Race.HUMAN: "Humano",
	Enums.Race.ELF: "Elfo",
	Enums.Race.DROW: "Elfo Oscuro",
	Enums.Race.GNOME: "Gnomo",
	Enums.Race.DWARF: "Enano"
}

const class_names = {
	Enums.Class.MAGE: "Mago",
	Enums.Class.CLERIC: "Clérigo",
	Enums.Class.WARRIOR: "Guerrero",
	Enums.Class.ASSASSIN: "Asesino",
	Enums.Class.THIEF: "Ladrón",
	Enums.Class.BARD: "Bardo",
	Enums.Class.DRUID: "Druida",
	Enums.Class.BANDIT: "Bandido",
	Enums.Class.PALADIN: "Paladín",
	Enums.Class.HUNTER: "Cazador",
	Enums.Class.FISHER: "Pescador",
	Enums.Class.BLACKSMITH: "Herrero",
	Enums.Class.LUMBERJACK: "Leñador",
	Enums.Class.MINER: "Minero",
	Enums.Class.CARPENTER: "Carpintero",
	Enums.Class.PIRATE: "Pirata"
}

const home_names = {
	Enums.Home.ULLATHORPE: "Ullathorpe",
	Enums.Home.NIX: "Nix",
	Enums.Home.BANDERBILL: "Banderbill",
	Enums.Home.LINDOS: "Lindos",
	Enums.Home.ARGHAL: "Arghal"
}
