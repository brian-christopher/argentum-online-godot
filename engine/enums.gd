extends RefCounted
class_name Enums

enum ClientPacketID{
	LoginExistingChar  	    ,#OLOGIN
	ThrowDices              ,#TIRDAD
	LoginNewChar            ,#NLOGIN
	Talk                    ,#;
	Yell                    ,#-
	Whisper                 ,#\
	Walk                    ,#M
	RequestPositionUpdate   ,#RPU
	Attack                  ,#AT
	PickUp                  ,#AG
	CombatModeToggle        ,#TAB        - SHOULD BE HANLDED JUST BY THE CLIENT!!
	SafeToggle              ,#/SEG & SEG  (SEG's behaviour has to be coded in the client)
	ResuscitationSafeToggle,
	RequestGuildLeaderInfo  ,#GLINFO
	RequestAtributes        ,#ATR
	RequestFame             ,#FAMA
	RequestSkills           ,#ESKI
	RequestMiniStats        ,#FEST
	CommerceEnd             ,#FINCOM
	UserCommerceEnd         ,#FINCOMUSU
	BankEnd                 ,#FINBAN
	UserCommerceOk          ,#COMUSUOK
	UserCommerceReject      ,#COMUSUNO
	Drop                    ,#TI
	CastSpell               ,#LH
	LeftClick               ,#LC
	DoubleClick             ,#RC
	Work                    ,#UK
	UseSpellMacro           ,#UMH
	UseItem                 ,#USA
	CraftBlacksmith         ,#CNS
	CraftCarpenter          ,#CNC
	WorkLeftClick           ,#WLC
	CreateNewGuild          ,#CIG
	SpellInfo               ,#INFS
	EquipItem               ,#EQUI
	ChangeHeading           ,#CHEA
	ModifySkills            ,#SKSE
	Train                   ,#ENTR
	CommerceBuy             ,#COMP
	BankExtractItem         ,#RETI
	CommerceSell            ,#VEND
	BankDeposit             ,#DEPO
	ForumPost               ,#DEMSG
	MoveSpell               ,#DESPHE
	ClanCodexUpdate         ,#DESCOD
	UserCommerceOffer       ,#OFRECER
	GuildAcceptPeace        ,#ACEPPEAT
	GuildRejectAlliance     ,#RECPALIA
	GuildRejectPeace        ,#RECPPEAT
	GuildAcceptAlliance     ,#ACEPALIA
	GuildOfferPeace         ,#PEACEOFF
	GuildOfferAlliance      ,#ALLIEOFF
	GuildAllianceDetails    ,#ALLIEDET
	GuildPeaceDetails       ,#PEACEDET
	GuildRequestJoinerInfo  ,#ENVCOMEN
	GuildAlliancePropList   ,#ENVALPRO
	GuildPeacePropList      ,#ENVPROPP
	GuildDeclareWar         ,#DECGUERR
	GuildNewWebsite         ,#NEWWEBSI
	GuildAcceptNewMember    ,#ACEPTARI
	GuildRejectNewMember    ,#RECHAZAR
	GuildKickMember         ,#ECHARCLA
	GuildUpdateNews         ,#ACTGNEWS
	GuildMemberInfo         ,#1HRINFO<
	GuildOpenElections      ,#ABREELEC
	GuildRequestMembership  ,#SOLICITUD
	GuildRequestDetails     ,#CLANDETAILS
	Online                  ,#/ONLINE
	Quit                    ,#/SALIR
	GuildLeave              ,#/SALIRCLAN
	RequestAccountState     ,#/BALANCE
	PetStand                ,#/QUIETO
	PetFollow               ,#/ACOMPAÑAR
	TrainList               ,#/ENTRENAR
	Rest                    ,#/DESCANSAR
	Meditate                ,#/MEDITAR
	Resucitate              ,#/RESUCITAR
	Heal                    ,#/CURAR
	Help                    ,#/AYUDA
	RequestStats            ,#/EST
	CommerceStart           ,#/COMERCIAR
	BankStart               ,#/BOVEDA
	Enlist                  ,#/ENLISTAR
	Information             ,#/INFORMACION
	Reward                  ,#/RECOMPENSA
	RequestMOTD             ,#/MOTD
	Uptime                  ,#/UPTIME
	PartyLeave              ,#/SALIRPARTY
	PartyCreate             ,#/CREARPARTY
	PartyJoin               ,#/PARTY
	Inquiry                 ,#/ENCUESTA ( with no params )
	GuildMessage            ,#/CMSG
	PartyMessage            ,#/PMSG
	CentinelReport          ,#/CENTINELA
	GuildOnline             ,#/ONLINECLAN
	PartyOnline             ,#/ONLINEPARTY
	CouncilMessage          ,#/BMSG
	RoleMasterRequest       ,#/ROL
	GMRequest               ,#/GM
	bugReport               ,#/_BUG
	ChangeDescription       ,#/DESC
	GuildVote               ,#/VOTO
	Punishments             ,#/PENAS
	ChangePassword          ,#/CONTRASEÑA
	Gamble                  ,#/APOSTAR
	InquiryVote             ,#/ENCUESTA ( with parameters )
	LeaveFaction            ,#/RETIRAR ( with no arguments )
	BankExtractGold         ,#/RETIRAR ( with arguments )
	BankDepositGold         ,#/DEPOSITAR
	Denounce                ,#/DENUNCIAR
	GuildFundate            ,#/FUNDARCLAN
	PartyKick               ,#/ECHARPARTY
	PartySetLeader          ,#/PARTYLIDER
	PartyAcceptMember       ,#/ACCEPTPARTY
	Ping                    ,#/PING
	
	#GM messages
	GMMessage               ,#/GMSG
	showName                ,#/SHOWNAME
	OnlineRoyalArmy         ,#/ONLINEREAL
	OnlineChaosLegion       ,#/ONLINECAOS
	GoNearby                ,#/IRCERCA
	comment                 ,#/REM
	serverTime              ,#/HORA
	Where                   ,#/DONDE
	CreaturesInMap          ,#/NENE
	WarpMeToTarget          ,#/TELEPLOC
	WarpChar                ,#/TELEP
	Silence                 ,#/SILENCIAR
	SOSShowList             ,#/SHOW SOS
	SOSRemove               ,#SOSDONE
	GoToChar                ,#/IRA
	invisible               ,#/INVISIBLE
	GMPanel                 ,#/PANELGM
	RequestUserList         ,#LISTUSU
	Working                 ,#/TRABAJANDO
	Hiding                  ,#/OCULTANDO
	Jail                    ,#/CARCEL
	KillNPC                 ,#/RMATA
	WarnUser                ,#/ADVERTENCIA
	EditChar                ,#/MOD
	RequestCharInfo         ,#/INFO
	RequestCharStats        ,#/STAT
	RequestCharGold         ,#/BAL
	RequestCharInventory    ,#/INV
	RequestCharBank         ,#/BOV
	RequestCharSkills       ,#/SKILLS
	ReviveChar              ,#/REVIVIR
	OnlineGM                ,#/ONLINEGM
	OnlineMap               ,#/ONLINEMAP
	Forgive                 ,#/PERDON
	Kick                    ,#/ECHAR
	Execute                 ,#/EJECUTAR
	BanChar                 ,#/BAN
	UnbanChar               ,#/UNBAN
	NPCFollow               ,#/SEGUIR
	SummonChar              ,#/SUM
	SpawnListRequest        ,#/CC
	SpawnCreature           ,#SPA
	ResetNPCInventory       ,#/RESETINV
	CleanWorld              ,#/LIMPIAR
	ServerMessage           ,#/RMSG
	NickToIP                ,#/NICK2IP
	IPToNick                ,#/IP2NICK
	GuildOnlineMembers      ,#/ONCLAN
	TeleportCreate          ,#/CT
	TeleportDestroy         ,#/DT
	RainToggle              ,#/LLUVIA
	SetCharDescription      ,#/SETDESC
	ForceMIDIToMap          ,#/FORCEMIDIMAP
	ForceWAVEToMap          ,#/FORCEWAVMAP
	RoyalArmyMessage        ,#/REALMSG
	ChaosLegionMessage      ,#/CAOSMSG
	CitizenMessage          ,#/CIUMSG
	CriminalMessage         ,#/CRIMSG
	TalkAsNPC               ,#/TALKAS
	DestroyAllItemsInArea   ,#/MASSDEST
	AcceptRoyalCouncilMember ,#/ACEPTCONSE
	AcceptChaosCouncilMember ,#/ACEPTCONSECAOS
	ItemsInTheFloor         ,#/PISO
	MakeDumb                ,#/ESTUPIDO
	MakeDumbNoMore          ,#/NOESTUPIDO
	DumpIPTables            ,#/DUMPSECURITY
	CouncilKick             ,#/KICKCONSE
	SetTrigger              ,#/TRIGGER
	AskTrigger              ,#/TRIGGER with no arguments
	BannedIPList            ,#/BANIPLIST
	BannedIPReload          ,#/BANIPRELOAD
	GuildMemberList         ,#/MIEMBROSCLAN
	GuildBan                ,#/BANCLAN
	BanIP                   ,#/BANIP
	UnbanIP                 ,#/UNBANIP
	CreateItem              ,#/CI
	DestroyItems            ,#/DEST
	ChaosLegionKick         ,#/NOCAOS
	RoyalArmyKick           ,#/NOREAL
	ForceMIDIAll            ,#/FORCEMIDI
	ForceWAVEAll            ,#/FORCEWAV
	RemovePunishment        ,#/BORRARPENA
	TileBlockedToggle       ,#/BLOQ
	KillNPCNoRespawn        ,#/MATA
	KillAllNearbyNPCs       ,#/MASSKILL
	LastIP                  ,#/LASTIP
	ChangeMOTD              ,#/MOTDCAMBIA
	SetMOTD                 ,#ZMOTD
	SystemMessage           ,#/SMSG
	CreateNPC               ,#/ACC
	CreateNPCWithRespawn    ,#/RACC
	ImperialArmour          ,#/AI1 - 4
	ChaosArmour             ,#/AC1 - 4
	NavigateToggle          ,#/NAVE
	ServerOpenToUsersToggle ,#/HABILITAR
	TurnOffServer           ,#/APAGAR
	TurnCriminal            ,#/CONDEN
	ResetFactions           ,#/RAJAR
	RemoveCharFromGuild     ,#/RAJARCLAN
	RequestCharMail         ,#/LASTEMAIL
	AlterPassword           ,#/APASS
	AlterMail               ,#/AEMAIL
	AlterName               ,#/ANAME
	ToggleCentinelActivated ,#/CENTINELAACTIVADO
	DoBackUp                ,#/DOBACKUP
	ShowGuildMessages       ,#/SHOWCMSG
	SaveMap                 ,#/GUARDAMAPA
	ChangeMapInfoPK         ,#/MODMAPINFO PK
	ChangeMapInfoBackup     ,#/MODMAPINFO BACKUP
	ChangeMapInfoRestricted ,#/MODMAPINFO RESTRINGIR
	ChangeMapInfoNoMagic    ,#/MODMAPINFO MAGIASINEFECTO
	ChangeMapInfoNoInvi     ,#/MODMAPINFO INVISINEFECTO
	ChangeMapInfoNoResu     ,#/MODMAPINFO RESUSINEFECTO
	ChangeMapInfoLand       ,#/MODMAPINFO TERRENO
	ChangeMapInfoZone       ,#/MODMAPINFO ZONA
	SaveChars               ,#/GRABAR
	CleanSOS                ,#/BORRAR SOS
	ShowServerForm          ,#/SHOW INT
	night                   ,#/NOCHE
	KickAllChars            ,#/ECHARTODOSPJS
	RequestTCPStats         ,#/TCPESSTATS
	ReloadNPCs              ,#/RELOADNPCS
	ReloadServerIni         ,#/RELOADSINI
	ReloadSpells            ,#/RELOADHECHIZOS
	ReloadObjects           ,#/RELOADOBJ
	Restart                 ,#/REINICIAR
	ResetAutoUpdate         ,#/AUTOUPDATE
	ChatColor               ,#/CHATCOLOR
	Ignored                 ,#/IGNORADO
	CheckSlot               ,#/SLOT
}

enum ServerPacketID{
	Logged                  ,# LOGGED
	RemoveDialogs           ,# QTDL
	RemoveCharDialog        ,# QDL
	NavigateToggle          ,# NAVEG
	Disconnect              ,# FINOK
	CommerceEnd             ,# FINCOMOK
	BankEnd                 ,# FINBANOK
	CommerceInit            ,# INITCOM
	BankInit                ,# INITBANCO
	UserCommerceInit        ,# INITCOMUSU
	UserCommerceEnd         ,# FINCOMUSUOK
	ShowBlacksmithForm      ,# SFH
	ShowCarpenterForm       ,# SFC
	NPCSwing                ,# N1
	NPCKillUser             ,# 6
	BlockedWithShieldUser   ,# 7
	BlockedWithShieldOther  ,# 8
	UserSwing               ,# U1
	UpdateNeeded            ,# REAU
	SafeModeOn              ,# SEGON
	SafeModeOff             ,# SEGOFF
	ResuscitationSafeOn     ,#
	ResuscitationSafeOff    ,#
	NobilityLost            ,# PN
	CantUseWhileMeditating  ,# M!
	UpdateSta               ,# ASS
	UpdateMana              ,# ASM
	UpdateHP                ,# ASH
	UpdateGold              ,# ASG
	UpdateExp               ,# ASE
	ChangeMap               ,# CM
	PosUpdate               ,# PU
	NPCHitUser              ,# N2
	UserHitNPC              ,# U2
	UserAttackedSwing       ,# U3
	UserHittedByUser        ,# N4
	UserHittedUser          ,# N5
	ChatOverHead            ,# ||
	ConsoleMsg              ,# || - Beware!! its the same as above, but it was properly splitted
	GuildChat               ,# |+
	ShowMessageBox          ,# !!
	UserIndexInServer       ,# IU
	UserCharIndexInServer   ,# IP
	CharacterCreate         ,# CC
	CharacterRemove         ,# BP
	CharacterMove           ,# MP, +, * and _ '
	CharacterChange         ,# CP
	ObjectCreate            ,# HO
	ObjectDelete            ,# BO
	BlockPosition           ,# BQ
	PlayMIDI                ,# TM
	PlayWave                ,# TW
	guildList               ,# GL
	AreaChanged             ,# CA
	PauseToggle             ,# BKW
	RainToggle              ,# LLU
	CreateFX                ,# CFX
	UpdateUserStats         ,# EST
	WorkRequestTarget       ,# T01
	ChangeInventorySlot     ,# CSI
	ChangeBankSlot          ,# SBO
	ChangeSpellSlot         ,# SHS
	Atributes               ,# ATR
	BlacksmithWeapons       ,# LAH
	BlacksmithArmors        ,# LAR
	CarpenterObjects        ,# OBR
	RestOK                  ,# DOK
	ErrorMsg                ,# ERR
	Blind                   ,# CEGU
	Dumb                    ,# DUMB
	ShowSignal              ,# MCAR
	ChangeNPCInventorySlot  ,# NPCI
	UpdateHungerAndThirst   ,# EHYS
	Fame                    ,# FAMA
	MiniStats               ,# MEST
	LevelUp                 ,# SUNI
	AddForumMsg             ,# FMSG
	ShowForumForm           ,# MFOR
	SetInvisible            ,# NOVER
	DiceRoll                ,# DADOS
	MeditateToggle          ,# MEDOK
	BlindNoMore             ,# NSEGUE
	DumbNoMore              ,# NESTUP
	SendSkills              ,# SKILLS
	TrainerCreatureList     ,# LSTCRI
	guildNews               ,# GUILDNE
	OfferDetails            ,# PEACEDE & ALLIEDE
	AlianceProposalsList    ,# ALLIEPR
	PeaceProposalsList      ,# PEACEPR
	CharacterInfo           ,# CHRINFO
	GuildLeaderInfo         ,# LEADERI
	GuildDetails            ,# CLANDET
	ShowGuildFundationForm  ,# SHOWFUN
	ParalizeOK              ,# PARADOK
	ShowUserRequest         ,# PETICIO
	TradeOK                 ,# TRANSOK
	BankOK                  ,# BANCOOK
	ChangeUserTradeSlot     ,# COMUSUINV
	SendNight               ,# NOC
	Pong                    ,#
	UpdateTagAndStatus      ,#
	
	#GM messages
	SpawnList               ,# SPL
	ShowSOSForm             ,# MSOS
	ShowMOTDEditionForm     ,# ZMOTD
	ShowGMPanelForm         ,# ABPANEL
	UserNameList            ,# LISTUSU
}

enum Heading {
	NONE = 0,
	NORTH = 1,
	EAST = 2,
	SOUTH = 3,
	WEST = 4, 
}

enum TileFlags {
	NONE = 0,
	BLOCKED = 1 << 0, 
	ROOF =1 << 1,
	WATER = 1 << 2,
} 

enum Race{
	HUMAN = 1,
	ELF,
	DROW,
	GNOME,
	DWARF
}

enum Home{
	ULLATHORPE = 1,
	NIX,
	BANDERBILL,
	LINDOS,
	ARGHAL,
}

enum Class{
	MAGE = 1,    # Mago
	CLERIC,      # Clérigo
	WARRIOR,     # Guerrero
	ASSASSIN,    # Asesino
	THIEF,       # Ladrón
	BARD,        # Bardo
	DRUID,       # Druida
	BANDIT,      # Bandido
	PALADIN,     # Paladín
	HUNTER,      # Cazador
	FISHER,      # Pescador
	BLACKSMITH,  # Herrero
	LUMBERJACK,  # Leñador
	MINER,       # Minero
	CARPENTER,   # Carpintero
	PIRATE       # Pirata
}

enum FontTypeNames{
	FONTTYPE_TALK,
	FONTTYPE_FIGHT,
	FONTTYPE_WARNING,
	FONTTYPE_INFO,
	FONTTYPE_INFOBOLD,
	FONTTYPE_EJECUCION,
	FONTTYPE_PARTY,
	FONTTYPE_VENENO,
	FONTTYPE_GUILD,
	FONTTYPE_SERVER,
	FONTTYPE_GUILDMSG,
	FONTTYPE_CONSEJO,
	FONTTYPE_CONSEJOCAOS,
	FONTTYPE_CONSEJOVesA,
	FONTTYPE_CONSEJOCAOSVesA,
	FONTTYPE_CENTINELA,
	FONTTYPE_GMMSG,
	FONTTYPE_GM,
	FONTTYPE_CITIZEN,
}

enum Skill{
	NONE = 0,
	SUERTE = 1,
	MAGIA = 2,
	ROBAR = 3,
	TACTICAS = 4,
	ARMAS = 5,
	MEDITAR = 6,
	APUÑALAR = 7,
	OCULTARSE = 8,
	SUPERVIVENCIA = 9,
	TALAR = 10,
	COMERCIAR = 11,
	DEFENSA = 12,
	PESCA = 13,
	MINERIA = 14,
	CARPINTERIA = 15,
	HERRERIA = 16,
	LIDERAZGO = 17,
	DOMAR = 18,
	PROYECTILES = 19,
	WRESTLING = 20,
	NAVEGACION = 21,
	
	#ESPECIALES#
	FUNDIR_METAL = 88
}


enum PlayerType{
	USER = 0x1,
	CONSEJERO = 0x2,
	SEMIDIOS = 0x4,
	DIOS = 0x8,
	ADMIN = 0x10,
	ROLE_MASTER = 0x20,
	CHAOS_COUNCIL = 0x40,
	ROYAL_COUNCIL = 0x80,
}

enum EObjType {
	USE_ONCE = 1,
	WEAPON = 2,
	ARMADURA = 3,
	ARBOLES = 4,
	GUITA = 5,
	PUERTAS = 6,
	CONTENEDORES = 7,
	CARTELES = 8,
	LLAVES = 9,
	FOROS = 10,
	POCIONES = 11,
	BEBIDAS = 13,
	LEÑA = 14,
	FOGATA = 15,
	ESCUDO = 16,
	CASCO = 17,
	ANILLO = 18,
	TELEPORT = 19,
	YACIMIENTO = 22,
	MINERALES = 23,
	PERGAMINOS = 24,
	INSTRUMENTOS = 26,
	YUNQUE = 27,
	FRAGUA = 28,
	BARCOS = 31,
	FLECHAS = 32,
	BOTELLA_VACIA = 33,
	BOTELLA_LLENA = 34,
	MANCHAS = 35,  # No se usa
	CUALQUIERA = 1000
}
