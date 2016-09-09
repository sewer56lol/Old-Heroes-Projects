echo off
set WORKING_DIRECTORY=%cd%
rem FIX FOR VARS INSIDE LOOPS
setlocal enabledelayedexpansion
rem
rem REARRANGE ADVERTISE
rem
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\English"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\French"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\German"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\Italian"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\Japanese"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\Korean"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\Spanish"
move /Y %WORKING_DIRECTORY%\ROM\advertise\* "%WORKING_DIRECTORY%\ROM\GameMenus"
move /Y %WORKING_DIRECTORY%\ROM\advertise\E\* "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\English"
move /Y %WORKING_DIRECTORY%\ROM\advertise\F\* "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\French"
move /Y %WORKING_DIRECTORY%\ROM\advertise\G\* "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\German"
move /Y %WORKING_DIRECTORY%\ROM\advertise\I\* "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\Italian"
move /Y %WORKING_DIRECTORY%\ROM\advertise\J\* "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\Japanese"
move /Y %WORKING_DIRECTORY%\ROM\advertise\K\* "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\Korean"
move /Y %WORKING_DIRECTORY%\ROM\advertise\S\* "%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\Spanish"

rem
rem ADD OTHER MENU ITEMS INSIDE
rem
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\TransitionModels"
move /Y %WORKING_DIRECTORY%\ROM\adv_ef_warpa.dff "%WORKING_DIRECTORY%\ROM\GameMenus\TransitionModels"
move /Y %WORKING_DIRECTORY%\ROM\adv_ef_warpb.dff "%WORKING_DIRECTORY%\ROM\GameMenus\TransitionModels"
move /Y %WORKING_DIRECTORY%\ROM\adv_sonicoutline.dff "%WORKING_DIRECTORY%\ROM\GameMenus\TransitionModels"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\SpecialStageTimeUpModels"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\SpecialStageTimeUpModels\French"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\SpecialStageTimeUpModels\German"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\SpecialStageTimeUpModels\Italian"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\SpecialStageTimeUpModels\Spanish"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\SpecialStageTimeUpModels\English & Japanese"
move /Y %WORKING_DIRECTORY%\ROM\adv_timeup.dff "%WORKING_DIRECTORY%\ROM\GameMenus\SpecialStageTimeUpModels\English&Japanese"
move /Y %WORKING_DIRECTORY%\ROM\adv_timeup_fr.dff "%WORKING_DIRECTORY%\ROM\GameMenus\SpecialStageTimeUpModels\French"
move /Y %WORKING_DIRECTORY%\ROM\adv_timeup_ge.dff "%WORKING_DIRECTORY%\ROM\GameMenus\SpecialStageTimeUpModels\German"
move /Y %WORKING_DIRECTORY%\ROM\adv_timeup_it.dff "%WORKING_DIRECTORY%\ROM\GameMenus\SpecialStageTimeUpModels\Italian"
move /Y %WORKING_DIRECTORY%\ROM\adv_timeup_sp.dff "%WORKING_DIRECTORY%\ROM\GameMenus\SpecialStageTimeUpModels\Spanish"

rem
rem Move Main Menu Chars!
rem
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\MainMenuCharacters"
for %%f in ("%WORKING_DIRECTORY%\ROM\GameMenus\adv_pl*.one") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\GameMenus\MainMenuCharacters\")
cd "%WORKING_DIRECTORY%\ROM\GameMenus\MainMenuCharacters\"
call %WORKING_DIRECTORY%\Scripts\Current\GenerateMenuCharacters.bat

rem
rem Decompress PRS Fonts
rem
cd %WORKING_DIRECTORY%
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\Fonts"
for %%f in ("%WORKING_DIRECTORY%\ROM\GameMenus\*.prs") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\GameMenus\Fonts")
for %%f in ("%WORKING_DIRECTORY%\ROM\GameMenus\Fonts\*.prs") do (%WORKING_DIRECTORY%\Tools\PrsDec\PrsDec.exe %%f %%~pnf.bin)
for %%f in ("%WORKING_DIRECTORY%\ROM\GameMenus\Fonts\*.prs") do (DEL /F %%f)

rem
rem Move over Unused Files
rem
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\Unused"
cd "%WORKING_DIRECTORY%\ROM\GameMenus\Unused"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\Unused\EarlyE3-10.8Title Screen"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\Unused\EarlyPre10.8ProtoAudioMenu"
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\Unused\E3BuildMainMenuAssets"
move /Y "%WORKING_DIRECTORY%\ROM\GameMenus\adv_title.one" "%WORKING_DIRECTORY%\ROM\GameMenus\Unused\EarlyE3-10.8Title Screen"
move /Y "%WORKING_DIRECTORY%\ROM\GameMenus\adv_audio.one" "%WORKING_DIRECTORY%\ROM\GameMenus\Unused\EarlyPre10.8ProtoAudioMenu"
move /Y "%WORKING_DIRECTORY%\ROM\GameMenus\adv_e3rom.one" "%WORKING_DIRECTORY%\ROM\GameMenus\Unused\E3BuildMainMenuAssets"
 
rem
rem Group Assets
rem
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\Assets"
for %%f in ("%WORKING_DIRECTORY%\ROM\GameMenus\adv_*") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\GameMenus\Assets")
move /Y "%WORKING_DIRECTORY%\ROM\GameMenus\as_emblem.one" "%WORKING_DIRECTORY%\ROM\GameMenus\Assets"
cd %WORKING_DIRECTORY%\ROM\GameMenus\Assets
call %WORKING_DIRECTORY%\Scripts\Current\GroupAssets.bat

rem
rem Rename Language Specific Assets
rem
for /D %%d in ("%WORKING_DIRECTORY%\ROM\GameMenus\LocalizedMenuAssets\*") do (cd %%d & call "%WORKING_DIRECTORY%\Scripts\Current\RenameLocaleFiles.bat")
cd %WORKING_DIRECTORY%

rem
rem Add Menu Text
rem
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\GameMenuText"
for %%f in ("%WORKING_DIRECTORY%\ROM\Text\*.utx") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\GameMenus\GameMenuText")
mkdir "%WORKING_DIRECTORY%\ROM\GameMenus\CreditsScreenText"
move /Y "%WORKING_DIRECTORY%\ROM\Text\staffroll.csv" "%WORKING_DIRECTORY%\ROM\GameMenus\CreditsScreenText"

rem
rem Bundle Game Code Together
rem
mkdir "%WORKING_DIRECTORY%\ROM\GameCode\StageRelocatableModuleFiles"
cd "%WORKING_DIRECTORY%\ROM\GameCode\StageRelocatableModuleFiles"
call %WORKING_DIRECTORY%\Scripts\Current\CreateLevelFolders.bat
cd %WORKING_DIRECTORY%\ROM\

for /D %%d in ("%WORKING_DIRECTORY%\ROM\GameCode\StageRelocatableModuleFiles\*") do (
	for %%f in (*.rel) do (
		set FileName=%%~nf
		set FolderName=%%~nd
		set First5Letters=!FileName:~0,5!
		set LevelIDRel=!FileName:~5,2!
		set LevelIDFolder=!FolderName:~6,2!
		if /I !First5Letters!==stage ( if /I !LevelIDRel!==!LevelIDFolder! ( move /Y %%f "%%d\" ) ) else ( move /Y %%f "%WORKING_DIRECTORY%\ROM\GameCode\" )
	)
)
move /Y "%WORKING_DIRECTORY%\ROM\&&systemdata\*.dol" "%WORKING_DIRECTORY%\ROM\GameCode\"
move /Y "%WORKING_DIRECTORY%\ROM\TSonic.str" "%WORKING_DIRECTORY%\ROM\GameCode\"
@echo Similar stages and zones share one unique .rel file, e.g. stage01D.rel is used for Seaside Hill and Ocean Palace.> "%WORKING_DIRECTORY%\ROM\GameCode\StageRelocatableModuleFiles\Note.txt"
@echo TSonic.str (and TSonicD.str) is simply a log of the compilation of the current ROM, showing what assets have been rebuilt for this version.\n Start.dol (typically named), is the equivalent of the main executable of the game (.elf on PS2, .exe on PC and .xex on XBOX).> "%WORKING_DIRECTORY%\ROM\GameCode\Note.txt"
rem
rem Set up Event Handling
rem
mkdir "%WORKING_DIRECTORY%\ROM\Events"
mkdir "%WORKING_DIRECTORY%\ROM\Events\TeamSonicEvents"
mkdir "%WORKING_DIRECTORY%\ROM\Events\TeamDarkEvents"
mkdir "%WORKING_DIRECTORY%\ROM\Events\TeamRoseEvents"
mkdir "%WORKING_DIRECTORY%\ROM\Events\TeamChaotixEvents"
mkdir "%WORKING_DIRECTORY%\ROM\Events\LastStoryEvents"
mkdir "%WORKING_DIRECTORY%\ROM\Events\Other~UnusedEvents"
for %%f in ("%WORKING_DIRECTORY%\ROM\event*") do (move /Y "%%f" "%WORKING_DIRECTORY%\ROM\Events\")
for %%f in ("%WORKING_DIRECTORY%\ROM\Events\event00*") do (move /Y "%%f" "%WORKING_DIRECTORY%\ROM\Events\TeamSonicEvents\")
for %%f in ("%WORKING_DIRECTORY%\ROM\Events\event01*") do (move /Y "%%f" "%WORKING_DIRECTORY%\ROM\Events\TeamDarkEvents\")
for %%f in ("%WORKING_DIRECTORY%\ROM\Events\event02*") do (move /Y "%%f" "%WORKING_DIRECTORY%\ROM\Events\TeamRoseEvents\")
for %%f in ("%WORKING_DIRECTORY%\ROM\Events\event03*") do (move /Y "%%f" "%WORKING_DIRECTORY%\ROM\Events\TeamChaotixEvents\")
for %%f in ("%WORKING_DIRECTORY%\ROM\Events\event04*") do (move /Y "%%f" "%WORKING_DIRECTORY%\ROM\Events\LastStoryEvents\")
for %%f in ("%WORKING_DIRECTORY%\ROM\Events\event*") do (move /Y "%%f" "%WORKING_DIRECTORY%\ROM\Events\Team SonicEvents\")

rem SONIC
rem Auto Gen Folders based on Suffix Discriminant
cd %WORKING_DIRECTORY%\ROM\Events\TeamSonicEvents
for %%f in ("%WORKING_DIRECTORY%\ROM\Events\TeamSonicEvents\event0*.scr") do (
	set suffix=%%~nxf
	if /I not !suffix:~-6!==_e.scr mkdir "%%~pnf"
)

for /D %%d in ("%WORKING_DIRECTORY%\ROM\Events\TeamSonicEvents\*") do (
	for %%f in ("%WORKING_DIRECTORY%\ROM\Events\TeamSonicEvents\*") do (
		set directoryname=%%~nxd
		set filename=%%~nf
		set test=!filename:~0,9!
		if /I !test!==!directoryname! (move /Y %%f %%d\)
	)
)

rem DARK
rem Auto Gen Folders based on Suffix Discriminant
cd %WORKING_DIRECTORY%\ROM\Events\TeamDarkEvents
for %%f in ("%WORKING_DIRECTORY%\ROM\Events\TeamDarkEvents\event0*.scr") do (
	set suffix=%%~nxf
	if /I not !suffix:~-6!==_e.scr mkdir "%%~pnf"
)

for /D %%d in ("%WORKING_DIRECTORY%\ROM\Events\TeamDarkEvents\*") do (
	for %%f in ("%WORKING_DIRECTORY%\ROM\Events\TeamDarkEvents\*") do (
		set directoryname=%%~nxd
		set filename=%%~nf
		set test=!filename:~0,9!
		if /I !test!==!directoryname! (move /Y %%f %%d\)
	)
)

rem ROSE
rem Auto Gen Folders based on Suffix Discriminant
cd %WORKING_DIRECTORY%\ROM\Events\TeamRoseEvents
for %%f in ("%WORKING_DIRECTORY%\ROM\Events\TeamRoseEvents\event0*.scr") do (
	set suffix=%%~nxf
	if /I not !suffix:~-6!==_e.scr mkdir "%%~pnf"
)

for /D %%d in ("%WORKING_DIRECTORY%\ROM\Events\TeamRoseEvents\*") do (
	for %%f in ("%WORKING_DIRECTORY%\ROM\Events\TeamRoseEvents\*") do (
		set directoryname=%%~nxd
		set filename=%%~nf
		set test=!filename:~0,9!
		if /I !test!==!directoryname! (move /Y %%f %%d\)
	)
)

rem CHAOTIX
rem Auto Gen Folders based on Suffix Discriminant
cd %WORKING_DIRECTORY%\ROM\Events\TeamChaotixEvents
for %%f in ("%WORKING_DIRECTORY%\ROM\Events\TeamChaotixEvents\event0*.scr") do (
	set suffix=%%~nxf
	if /I not !suffix:~-6!==_e.scr mkdir "%%~pnf"
)

for /D %%d in ("%WORKING_DIRECTORY%\ROM\Events\TeamChaotixEvents\*") do (
	for %%f in ("%WORKING_DIRECTORY%\ROM\Events\TeamChaotixEvents\*") do (
		set directoryname=%%~nxd
		set filename=%%~nf
		set test=!filename:~0,9!
		if /I !test!==!directoryname! (move /Y %%f %%d\)
	)
)

rem LAST
rem Auto Gen Folders based on Suffix Discriminant
cd %WORKING_DIRECTORY%\ROM\Events\LastStoryEvents
for %%f in ("%WORKING_DIRECTORY%\ROM\Events\LastStoryEvents\event0*.scr") do (
	set suffix=%%~nxf
	if /I not !suffix:~-6!==_e.scr mkdir "%%~pnf"
)

for /D %%d in ("%WORKING_DIRECTORY%\ROM\Events\LastStoryEvents\*") do (
	for %%f in ("%WORKING_DIRECTORY%\ROM\Events\LastStoryEvents\*") do (
		set directoryname=%%~nxd
		set filename=%%~nf
		set test=!filename:~0,9!
		if /I !test!==!directoryname! (move /Y %%f %%d\)
	)
)

rem UNUSED
rem Auto Gen Folders based on Suffix Discriminant
cd %WORKING_DIRECTORY%\ROM\Events\Other~UnusedEvents
for %%f in ("%WORKING_DIRECTORY%\ROM\Events\Other~UnusedEvents\event0*.scr") do (
	set suffix=%%~nxf
	if /I not !suffix:~-6!==_e.scr mkdir "%%~pnf"
)

for /D %%d in ("%WORKING_DIRECTORY%\ROM\Events\Other~UnusedEvents\*") do (
	for %%f in ("%WORKING_DIRECTORY%\ROM\Events\Other~UnusedEvents\*") do (
		set directoryname=%%~nxd
		set filename=%%~nf
		set test=!filename:~0,9!
		if /I !test!==!directoryname! (move /Y %%f %%d\)
	)
)

rem
rem Handle Character Models
rem
cd %WORKING_DIRECTORY%\ROM\
ren playmodel "CharacterModels"
cd %WORKING_DIRECTORY%\ROM\CharacterModels
call %WORKING_DIRECTORY%\Scripts\Current\CreateCharacterFolders.bat

rem For Each Directory Do Sort Out Animations Models And Textures
for /D %%d in ("%WORKING_DIRECTORY%\ROM\CharacterModels\*") do (
	for %%f in ("%%d\*") do (
		set filename=%%~nf
		set directory=%%~nxf
		set test=!filename:~-4!
		if /I !test!==_anm (mkdir "%%~pfAnimations" & move "%%f" "%%~pfAnimations\")
	)
)

for /D %%d in ("%WORKING_DIRECTORY%\ROM\CharacterModels\*") do (
	for %%f in ("%%d\*") do (
		set filename=%%~nf
		set directory=%%~nxf
		set test=!filename:~-4!
		if /I !test!==_dff (mkdir "%%~pfModels" & move "%%f" "%%~pfModels\")
	)
)

for /D %%d in ("%WORKING_DIRECTORY%\ROM\CharacterModels\*") do (
	for %%f in ("%%d\*") do (
		set filename=%%~nxf
		set directory=%%~nxf
		set test=!filename:~-4!
		if /I !test!==.txd (mkdir "%%~pfTextures" & move "%%f" "%%~pfTextures\")
	)
)

rem
rem Set up Stages Rewrite Full X2
rem

mkdir "%WORKING_DIRECTORY%\ROM\Levels\ActionStages"
mkdir "%WORKING_DIRECTORY%\ROM\Levels\Other\SETIDTable"
mkdir "%WORKING_DIRECTORY%\ROM\Levels\Other\CommonParticleData"
mkdir "%WORKING_DIRECTORY%\ROM\Levels\Other\"
mkdir "%WORKING_DIRECTORY%\ROM\Levels\CommonObjects"
mkdir "%WORKING_DIRECTORY%\ROM\Levels\Unused\CommonObjects"
cd "%WORKING_DIRECTORY%\ROM\Levels\ActionStages"
call %WORKING_DIRECTORY%\Scripts\Current\CreateLevelFolders.bat
for /D %%d in ("%WORKING_DIRECTORY%\ROM\Levels\ActionStages\*") do (
	mkdir "%%d\Geometry"
	mkdir "%%d\CustomFalcoEnemy"
	mkdir "%%d\StageSpecificObjects\GeometryAndEnvironmentModels"
	mkdir "%%d\TitleCardMissionText"
	mkdir "%%d\TitleCard"
	mkdir "%%d\TitleCard\ExtraMission"
	mkdir "%%d\TitleCard\SuperHard"
	mkdir "%%d\Collision"
	mkdir "%%d\Collision\WaterCollision"
	mkdir "%%d\Collision\DeathPlanes"
	mkdir "%%d\ObjectLayouts"
	mkdir "%%d\ObjectLayouts\AllTeams"
	mkdir "%%d\ObjectLayouts\TeamSonic"
	mkdir "%%d\ObjectLayouts\TeamDark"
	mkdir "%%d\ObjectLayouts\TeamRose"
	mkdir "%%d\ObjectLayouts\TeamChaotix"
	mkdir "%%d\ObjectLayouts\SuperHard"
	mkdir "%%d\ObjectLayouts\DecorationLayouts"	
	mkdir "%%d\IdleAutoplayDemos"
	mkdir "%%d\LightingData"
	mkdir "%%d\CameraData"
	mkdir "%%d\GeometryVisibilityData"
	mkdir "%%d\Textures"
	mkdir "%%d\IndirectionalData"
	mkdir "%%d\ParticleData"
	mkdir "%%d\ExtraSplineData"
	mkdir "%%d\Unknown"
)

REM MOVE ALL THE STUFF
REM MOVE ALL THE STUFF
REM MOVE ALL THE STUFF
for %%f in ("%WORKING_DIRECTORY%\ROM\s**obj.one") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**MRG.one") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**_flyer.one") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**.one") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\stg**.one") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\collisions\*.cl") do (move /Y "%%f" "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**_PB.bin") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**_P1.bin") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**_P2.bin") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**_P3.bin") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**_P4.bin") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**_P5.bin") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**_DB.bin") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\stgtitle\mission\*.bmp") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\stgtitle\*.one") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**.dmo") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**_light.bin") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**_cam.bin") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**_blk.bin") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**_indinfo.dat") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**_ptcl.bin") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**_ptclplay.bin") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**.txc") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\s**.spl") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
for %%f in ("%WORKING_DIRECTORY%\ROM\Textures\s**.txd") do (
	set filename=%%~nf
	set test1=!filename:~-0,3!
	if /I not !test1!==stg (set test2=!filename:~0,8!) else (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
	if /I not !test2!==startbtn (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\ActionStages")
)

REM COMMON OBJS
REM Fixes for object filter inaccuracies, and move the common objects.
for %%f in ("%WORKING_DIRECTORY%\ROM\Levels\ActionStages\stg06_kw_hanabi_**.one") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\CommonObjects")
move /Y "%WORKING_DIRECTORY%\ROM\Levels\ActionStages\stgmem0910.one" "%WORKING_DIRECTORY%\ROM\Levels\CommonObjects"

REM Manually move Common Objects Across to the correct directories.
for %%f in ("%WORKING_DIRECTORY%\ROM\obj*_Prop*.dff") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\CommonObjects")
for %%f in ("%WORKING_DIRECTORY%\ROM\bob*.one") do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Levels\CommonObjects")
move /Y "%WORKING_DIRECTORY%\ROM\rain_ita.dff" "%WORKING_DIRECTORY%\ROM\Levels\CommonObjects"
move /Y "%WORKING_DIRECTORY%\ROM\obj0708_sparks.dff" "%WORKING_DIRECTORY%\ROM\Levels\CommonObjects"
move /Y "%WORKING_DIRECTORY%\ROM\primModels.one" "%WORKING_DIRECTORY%\ROM\Levels\Unused\CommonObjects"
move /Y "%WORKING_DIRECTORY%\ROM\indirectEditor.dff" "%WORKING_DIRECTORY%\ROM\Levels\Unused\CommonObjects"
move /Y "%WORKING_DIRECTORY%\ROM\null.dff" "%WORKING_DIRECTORY%\ROM\Levels\Unused\CommonObjects"
move /Y "%WORKING_DIRECTORY%\ROM\comobj.one" "%WORKING_DIRECTORY%\ROM\Levels\CommonObjects"

mkdir  "%WORKING_DIRECTORY%\ROM\Levels\CommonObjects\Bomb Effect\Model\"
mkdir  "%WORKING_DIRECTORY%\ROM\Levels\CommonObjects\Bomb Effect\Animation\"
move /Y "%WORKING_DIRECTORY%\ROM\ef_bomb.dff" "%WORKING_DIRECTORY%\ROM\Levels\CommonObjects\Bomb Effect\Model\"
move /Y "%WORKING_DIRECTORY%\ROM\ef_bomb.anm" "%WORKING_DIRECTORY%\ROM\Levels\CommonObjects\Bomb Effect\Animation\"

cd "%WORKING_DIRECTORY%\ROM\Levels\CommonObjects"
call %WORKING_DIRECTORY%\Scripts\Current\RenameCommonObjects.bat

rem
rem Move Stuff Level Stuff To Proper Directory
rem

for /D %%d in ("%WORKING_DIRECTORY%\ROM\Levels\ActionStages\*") do (
	set StageDirectory=%%~nd
	for %%f in ("%WORKING_DIRECTORY%\ROM\Levels\ActionStages\*") do ( 
		set FileName=%%~nf
		set directory=%%~nxd
		set stagedirshort=!StageDirectory:~6,2!
		set test1=!FileName:~-0,3!
		set TeamChaotixTest=!FileName:~-0,15!
		set EnglishTeamTitleTest=!FileName:~-1!
		set Team4CharTest=!FileName:~-0,12!
		set Team5CharTest=!FileName:~-0,13!
		set GenericStageTitleTest=!FileName:~-0,13!
		set GenericStageTitleID=!FileName:~13,3!
		
		REM TEST FOR DIRECTORY
		if /I not !test1!==stg (set test2=!FileName:~1,2!) else (set test2=!FileName:~3,2!)
		if /I !test2!==!stagedirshort! (move /Y "%%~pnxf" "%%~pf!StageDirectory!\")
		
		REM TEST FOR TEAMS
		
		if /I !TeamChaotixTest!==stgCHAOTIXtitle (if /I !EnglishTeamTitleTest!==E (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\TeamBattleTitles\Chaotix\English\") else (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\TeamBattleTitles\Chaotix\"))
		
		if /I !Team4CharTest!==stgDARKtitle (if /I !EnglishTeamTitleTest!==E (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\TeamBattleTitles\Dark\English") else (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\TeamBattleTitles\Dark\"))
		
		if /I !Team4CharTest!==stgROSEtitle (if /I !EnglishTeamTitleTest!==E (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\TeamBattleTitles\Rose\English") else (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\TeamBattleTitles\Rose\"))
		
		if /I !Team5CharTest!==stgSONICtitle (if /I !EnglishTeamTitleTest!==E (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\TeamBattleTitles\Sonic\English") else (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\TeamBattleTitles\Sonic\"))
		
		if /I !GenericStageTitleTest!==stgtitle_disp (
			if /I !GenericStageTitleID!==EEX (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\English\ExtraMission\")
			if /I !GenericStageTitleID!==ESH (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\English\SuperHard\")
			if /I !GenericStageTitleID!==E (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\English\")
			
			if /I !GenericStageTitleID!==FSH (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\French\ExtraMission\")
			if /I !GenericStageTitleID!==FEX (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\French\SuperHard\")
			if /I !GenericStageTitleID!==F (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\French\")
			
			if /I !GenericStageTitleID!==GSH (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\German\ExtraMission\")
			if /I !GenericStageTitleID!==GEX (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\German\SuperHard\")
			if /I !GenericStageTitleID!==G (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\German\")
			
			if /I !GenericStageTitleID!==ISH (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\Italian\ExtraMission\")
			if /I !GenericStageTitleID!==IEX (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\Italian\SuperHard\")
			if /I !GenericStageTitleID!==I (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\Italian\")
			
			if /I !GenericStageTitleID!==SSH (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\Spanish\ExtraMission\")
			if /I !GenericStageTitleID!==SEX (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\Spanish\SuperHard\")
			if /I !GenericStageTitleID!==S (move /Y "%%~pnxf" "%%~pf\Stage XX - Common Assets\GenericStageTitles\Spanish\")
		)
		echo "Current Directory: !directory!"
	)
)

for /D %%d in ("%WORKING_DIRECTORY%\ROM\Levels\ActionStages\*") do (
	for %%f in ("%%d\*") do ( 
		set FullFileName=%%~nxf
		set FileName=%%~nf
		set Extension=%%~xf
		set Last3Chars=!FileName:~-3!
		set Last5Chars=!FileName:~-5!
		set Last7Chars=!FileName:~-7!
		set Last8Chars=!FileName:~-8!
		set StageTitleTest=!FileName:~5,10!
		set StageTitleTestExtended=!FileName:~5,12!
		REM echo "Currently Processing File: !FileName!"
		echo !Extension!
		REM Move Stage Title Card Mission Text
		if /I !Extension!==.bmp (move /Y "%%f" "%%d\TitleCardMissionText\")
		REM Move Stage Specific Objects
		if /I !Last3Chars!==obj (move /Y "%%f" "%%d\StageSpecificObjects\")
		if /I !Last3Chars!==MRG (move /Y "%%f" "%%d\StageSpecificObjects\GeometryAndEnvironmentModels\")
		REM Move Stage All Team Layout
		if /I !Last3Chars!==_PB (move /Y "%%f" "%%d\ObjectLayouts\AllTeams\")
		REM Move Stage Team Sonic Layout
		if /I !Last3Chars!==_P1 (move /Y "%%f" "%%d\ObjectLayouts\TeamSonic\")
		REM Move Stage Team Dark Layout
		if /I !Last3Chars!==_P2 (move /Y "%%f" "%%d\ObjectLayouts\TeamDark\")
		REM Move Stage Team Rose Layout
		if /I !Last3Chars!==_P3 (move /Y "%%f" "%%d\ObjectLayouts\TeamRose\")
		REM Move Stage Team Chaotix Layout
		if /I !Last3Chars!==_P4 (move /Y "%%f" "%%d\ObjectLayouts\TeamChaotix\")
		REM Move Stage Super Hard Layout
		if /I !Last3Chars!==_P5 (move /Y "%%f" "%%d\ObjectLayouts\SuperHard\")
		REM Move Stage Decoration Layout
		if /I !Last3Chars!==_DB (move /Y "%%f" "%%d\ObjectLayouts\DecorationLayouts\")
		REM Move Stage Collision Data
		if /I !Extension!==.cl (
			if /I !Last3Chars!==_wt (move /Y "%%f" "%%d\Collision\WaterCollision\")
			if /I !Last3Chars!==_WT (move /Y "%%f" "%%d\Collision\WaterCollision\")
			if /I !Last3Chars!==_xx (move /Y "%%f" "%%d\Collision\DeathPlanes\")
			if /I !Last3Chars!==_XX (move /Y "%%f" "%%d\Collision\DeathPlanes\")
			move /Y "%%f" "%%d\Collision\"
		)
		REM Move Stage Title Cards
		if /I !StageTitleTestExtended!==title_dispEX (move /Y "%%f" "%%d\TitleCard\ExtraMission\")
		if /I !StageTitleTestExtended!==title_dispSH (move /Y "%%f" "%%d\TitleCard\SuperHard\")
		if /I !StageTitleTest!==title_disp (move /Y "%%f" "%%d\TitleCard\")
		REM Move Stage Autoplay Demos
		if /I !Extension!==.dmo (move /Y "%%f" "%%d\IdleAutoplayDemos\")
		REM Move Lighting Data
		if /I !Last5Chars!==light (move /Y "%%f" "%%d\LightingData\")
		REM Move FalcoEnemy
		if /I !Last5Chars!==flyer (move /Y "%%f" "%%d\CustomFalcoEnemy")
		REM Move Camera Data
		if /I !Last3Chars!==cam (move /Y "%%f" "%%d\CameraData\")
		REM Move Geometry Visibility Data
		if /I !Last3Chars!==blk (move /Y "%%f" "%%d\GeometryVisibilityData\")
		REM Move Textures
		if /I !Extension!==.txd (move /Y "%%f" "%%d\Textures\")
		if /I !Extension!==.txc (move /Y "%%f" "%%d\Textures\")
		REM Move Indirectional Data
		if /I !Last7Chars!==indinfo (move /Y "%%f" "%%d\IndirectionalData\")
		REM Move Particle Data
		if /I !Last5Chars!==_ptcl (move /Y "%%f" "%%d\ParticleData\")
		if /I !Last8Chars!==ptclplay (move /Y "%%f" "%%d\ParticleData\")
		REM Move Spline Data
		if /I !Extension!==.spl (move /Y "%%f" "%%d\ExtraSplineData\")
		REM Move Geometry
		set GeomFileNameTest1=!FileName:~1,2!
		set GeomFileNameTest2=!FileName:~3,2!
		if /I !FileName!==s!GeomFileNameTest1! (move /Y "%%f" "%%d\Geometry\")
		if /I !FileName!==stg!GeomFileNameTest2! (move /Y "%%f" "%%d\Geometry\")
	)
)

REM
REM SORT OUT THE UNUSUAL LEVEL STUFF (This is pt2 to last method)
REM

REM Move Unknown OBJ to Unknown
move /Y "%WORKING_DIRECTORY%\ROM\stg05.bin" "%WORKING_DIRECTORY%\ROM\Levels\ActionStages\Stage 05 - Casino Park\Unknown\"
move /Y "%WORKING_DIRECTORY%\ROM\startStage.inf" "%WORKING_DIRECTORY%\ROM\Levels\Other\"
move /Y "%WORKING_DIRECTORY%\ROM\setidtbl.bin" "%WORKING_DIRECTORY%\ROM\Levels\Other\SETIDTable\"
move /Y "%WORKING_DIRECTORY%\ROM\cmn_ptcl.bin" "%WORKING_DIRECTORY%\ROM\Levels\Other\CommonParticleData\"

rem
rem Remove all of the remaining stage titles.
rem
for %%i in (%WORKING_DIRECTORY%\ROM\Levels\ActionStages\*.bmp) do (echo %%i & mkdir "%WORKING_DIRECTORY%\ROM\Levels\Unused\TitleCardMissionText" & move /Y "%%i" "%WORKING_DIRECTORY%\ROM\Levels\Unused\TitleCardMissionText\")


rem
rem Do all the Textures
rem
cd %WORKING_DIRECTORY%\ROM\
ren "textures" "Textures"
mkdir "%WORKING_DIRECTORY%\ROM\Textures\Common\Effects"
mkdir "%WORKING_DIRECTORY%\ROM\Textures\Common\Loading"
mkdir "%WORKING_DIRECTORY%\ROM\Textures\Common\StartButton"

for %%f in (%WORKING_DIRECTORY%\ROM\Textures\*) do (
	set FileName=%%~nf
	set Extension=%%~xf
	set First3Chars=!FileName:~0,3!
	set First8Chars=!FileName:~0,8!
	
	echo "Extension:!Extension!"
	echo "FileName:!FileName!"
	if /I !First3Chars!==obj (move /Y %%f "%WORKING_DIRECTORY%\ROM\Textures\Common\")
	if /I !First3Chars!==eff (move /Y %%f "%WORKING_DIRECTORY%\ROM\Textures\Common\Effects\")
	if /I !FileName!==rain_ita (move /Y %%f "%WORKING_DIRECTORY%\ROM\Textures\Common\Effects\")
	if /I !FileName!==cmn_effect (move /Y %%f "%WORKING_DIRECTORY%\ROM\Textures\Common\Effects\")
	if /I !First3Chars!==ef_ (move /Y %%f "%WORKING_DIRECTORY%\ROM\Textures\Common\Effects\")
	if /I !First8Chars!==startbtn (move /Y %%f "%WORKING_DIRECTORY%\ROM\Textures\Common\StartButton\")
	if /I !FileName!==loading (move /Y %%f "%WORKING_DIRECTORY%\ROM\Textures\Common\Loading\")
	if /I !First3Chars!==en_ (mkdir "%WORKING_DIRECTORY%\ROM\Textures\Unused\Enemies" & move /Y %%f "%WORKING_DIRECTORY%\ROM\Textures\Unused\Enemies\")
	if /I !FileName!==e3adv (mkdir "%WORKING_DIRECTORY%\ROM\Textures\Unused\E3" & move /Y %%f "%WORKING_DIRECTORY%\ROM\Textures\Unused\E3\")
	if /I !FileName!==comsoon (mkdir "%WORKING_DIRECTORY%\ROM\Textures\Unused\E3" & move /Y %%f "%WORKING_DIRECTORY%\ROM\Textures\Unused\E3\")

	REM NTSC-U SPECIFIC
	if /I !FileName!==stg40_indinfo (mkdir "%WORKING_DIRECTORY%\ROM\Textures\Unused\OutOfPlace\Stage 40 - Bonus Stage 2\IndirectionalData" & move /Y %%f "%WORKING_DIRECTORY%\ROM\Textures\Unused\OutOfPlace\Stage 40 - Bonus Stage 2\IndirectionalData\")
	
	REM PICK UP ANY OTHER SCRAPS LEFT
	if /I not !Extension!==.txd (mkdir "%WORKING_DIRECTORY%\ROM\Textures\Unused\OutOfPlace\Other" & move /Y %%f "%WORKING_DIRECTORY%\ROM\Textures\Unused\OutOfPlace\Other\")
)

for %%f in (%WORKING_DIRECTORY%\ROM\Textures\*.txd) do (move /Y %%f "%WORKING_DIRECTORY%\ROM\Textures\Unused\")

rem
rem Sort out the Enemies
rem
cd %WORKING_DIRECTORY%\ROM
mkdir "Enemies~Bosses\Bosses"
mkdir "Enemies~Bosses\CommonAssets"
mkdir "Enemies~Bosses\Enemies"

for /D %%d in (%WORKING_DIRECTORY%\ROM\Enemies~Bosses\*) do (cd %%d && call %WORKING_DIRECTORY%\Scripts\Current\GenerateEnemyNames.bat)
for %%f in (%WORKING_DIRECTORY%\ROM\*.one) do (
	set FileName=%%~nf
	set First3Chars=!FileName:~0,3!
	set First7Chars=!FileName:~0,7!
	if /I !First7Chars!==chrboss (move /Y %%f "%WORKING_DIRECTORY%\ROM\Enemies~Bosses\Bosses\")
	if /I !FileName!==en_common (move /Y %%f "%WORKING_DIRECTORY%\ROM\Enemies~Bosses\CommonAssets\")
	if /I !FileName!==en_icon (move /Y %%f "%WORKING_DIRECTORY%\ROM\Enemies~Bosses\CommonAssets\")
	if /I !First3Chars!==bs_ (move /Y %%f "%WORKING_DIRECTORY%\ROM\Enemies~Bosses\Bosses\")
	if /I !First3Chars!==en_ (move /Y %%f "%WORKING_DIRECTORY%\ROM\Enemies~Bosses\Enemies\")
)
for /D %%d in (%WORKING_DIRECTORY%\ROM\Enemies~Bosses\*) do (
	cd %%d
	for %%f in (%%d\*.one) do (
		set FileName=%%~nf
		set First12Chars=!FileName:~0,12!
		if /I !FileName!==bs_albatross (move /Y %%f "EggAlbatross\")
		if /I !FileName!==bs_egghawk (move /Y %%f "EggHawk\")
		if /I !FileName!==bs_kingpawn (move /Y %%f "EggEmperor\")
		if /I !FileName!==chrboss_disp (move /Y %%f "TeamBattleIcons\TeamSonic\")
		if /I !FileName!==chrboss_dispC (move /Y %%f "TeamBattleIcons\TeamChaotix\")
		if /I !FileName!==chrboss_dispD (move /Y %%f "TeamBattleIcons\TeamDark\")
		if /I !FileName!==chrboss_dispR (move /Y %%f "TeamBattleIcons\TeamRose\")
		if /I !FileName!==en_common (move /Y %%f "CommonAssets\")
		if /I !FileName!==en_capture (move /Y %%f "Klagen\")
		if /I !FileName!==en_e2000 (move /Y %%f "E2000\")
		if /I !First12Chars!==en_eggmobile (move /Y %%f "EggMobile\")
		if /I !FileName!==en_flyer (move /Y %%f "Falco\")
		if /I !FileName!==en_icon (move /Y %%f "EnemyIcons\")
		if /I !FileName!==en_magician (move /Y %%f "EggMagician\")
		if /I !FileName!==en_metalsonic1st (move /Y %%f "MetalSonic1\")
		if /I !FileName!==en_metalsonic2nd (move /Y %%f "MetalSonic2\")
		if /I !FileName!==en_pawn (move /Y %%f "EggPawn\")
		if /I !FileName!==en_pawn_roulette (move /Y %%f "EggPawnCasino\")
		if /I !FileName!==en_rinoliner (move /Y %%f "Rhinoliner\")
		if /I !FileName!==en_searcher (move /Y %%f "Flapper\")
		if /I !FileName!==en_turtle (move /Y %%f "Cameron\")
		if /I !FileName!==en_wall (move /Y %%f "HeavyEggHammer\")
	)
)

rem
rem Deal with SFX
rem
cd %WORKING_DIRECTORY%\ROM
mkdir "SoundEffects\SoundEffectTables"
mkdir "SoundEffects\Sounds"
mkdir "SoundEffects\SoundEffectSoundLibConfiguration"
@echo Similar stages and zones share one unique .mlt file, e.g. SE_S01ST.mlt is used for Seaside Hill and Ocean Palace.> "%WORKING_DIRECTORY%\ROM\SoundEffects\Sounds\Note.txt"
move /Y %WORKING_DIRECTORY%\ROM\GCAX.conf "%WORKING_DIRECTORY%\ROM\SoundEffects\SoundEffectSoundLibConfiguration\"
for %%f in (%WORKING_DIRECTORY%\ROM\se_*.mlt) do (move /Y %%f "%WORKING_DIRECTORY%\ROM\SoundEffects\Sounds\")
for %%f in (%WORKING_DIRECTORY%\ROM\se_*.bin) do (move /Y %%f "%WORKING_DIRECTORY%\ROM\SoundEffects\SoundEffectTables\")
cd %WORKING_DIRECTORY%\ROM\SoundEffects\Sounds\ && call %WORKING_DIRECTORY%\Scripts\Current\CreateLevelFolders.bat
cd %WORKING_DIRECTORY%\ROM\SoundEffects\SoundEffectTables\ && call %WORKING_DIRECTORY%\Scripts\Current\CreateLevelFolders.bat
for /D %%d in ("%WORKING_DIRECTORY%\ROM\SoundEffects\*") do (
	mkdir "%%d\Player\TeamSonic"
	mkdir "%%d\Player\TeamDark"
	mkdir "%%d\Player\TeamRose"
	mkdir "%%d\Player\TeamChaotix"
	mkdir "%%d\Enemy"
	mkdir "%%d\Common"
	mkdir "%%d\Vocal"
	mkdir "%%d\Unknown"
	for /D %%0 in ("%%d\*") do (
		for %%f in (%%d\*) do (
			set FileName=%%~nf
			set FolderName=%%~n0
			set LevelIDSFX=!FileName:~4,2!
			
			set LevelIDFolder=!FolderName:~6,2!
			
			set SFXTypeShort=!FileName:~3,2!
			set SFXType=!FileName:~3,5!
			
			echo "FolderName: !FolderName!"
			echo "FileName: !FileName!"
			echo "Level ID SFX CMP: !LevelIDSFX! - !LevelIDFolder!"
			echo "SFXType: !SFXType!"
			
			if /I not !FileName!==GCAX (if /I !LevelIDSFX!==!LevelIDFolder! (move /Y %%f "%%0\"))
			if /I !SFXTypeShort!==pl (move /Y %%f "%%d\Player\")
			if /I !SFXTypeShort!==en (move /Y %%f "%%d\Enemy\")
			if /I !SFXTypeShort!==cn (move /Y %%f "%%d\Common\")
			if /I !SFXTypeShort!==vo (move /Y %%f "%%d\Vocal\")
			if /I !SFXTypeShort!==sy (move /Y %%f "%%d\Unknown\")
			if /I !SFXType!==CMNGK (move /Y %%f "%%d\Common\")
			if /I !SFXType!==VOICE (move /Y %%f "%%d\Vocal\")
			if /I !SFXType!==BASIC (move /Y %%f "%%d\Common\")
			if /I !SFXType!==CH_TS (move /Y %%f "%%d\Player\TeamSonic\")
			if /I !SFXType!==CH_TD (move /Y %%f "%%d\Player\TeamDark\")
			if /I !SFXType!==CH_TR (move /Y %%f "%%d\Player\TeamRose\")
			if /I !SFXType!==CH_TC (move /Y %%f "%%d\Player\TeamChaotix\")
		)
	)
)

rem
rem Deal with the Heads up Display.
rem
cd %WORKING_DIRECTORY%\ROM\
mkdir HUD\ResultsScreen\TimeOnly
mkdir HUD\ResultsScreen\Normal
mkdir HUD\ResultsScreen\BonusStage
mkdir HUD\TeamSonic\
mkdir HUD\TeamDark\
mkdir HUD\TeamChaotix\
mkdir HUD\TeamRose\
mkdir HUD\2Player\

for /D %%d in (%WORKING_DIRECTORY%\ROM\HUD\*) do (
	mkdir "%%d\English"
	mkdir "%%d\French"
	mkdir "%%d\German"
	mkdir "%%d\Italian"
	mkdir "%%d\Korean"
	mkdir "%%d\Spanish"
)

for /D %%1 in (%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\*) do (
		mkdir "%%1\English"
		mkdir "%%1\French"
		mkdir "%%1\German"
		mkdir "%%1\Italian"
		mkdir "%%1\Korean"
		mkdir "%%1\Spanish"
)

for %%f in (%WORKING_DIRECTORY%\ROM\*.one) do (
	set FileName=%%~nf
	set HUDIdentifier=!FileName:~0,9!
	set ResultIdentifier=!FileName:~0,6!
	set HUDType=!FileName:~9,1!
	set HUDLanguage=!FileName:~-1!
	set ResultType=!FileName:~6,1!
	
	if /I !HUDIdentifier!==game_disp (
		REM TYPE SONIC
		if /I !FileName!==game_disp (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamSonic\")
		if /I !HUDType!==E (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamSonic\English\")
		if /I !HUDType!==F (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamSonic\French\")
		if /I !HUDType!==G (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamSonic\German\")
		if /I !HUDType!==I (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamSonic\Italian\")
		if /I !HUDType!==K (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamSonic\Korean\")
		if /I !HUDType!==S (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamSonic\Spanish\")
		
		REM TYPE 2PLAYER
		if /I !HUDType!==2 (
			if /I !FileName!==game_disp2 (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\2Player\")
			if /I !HUDLanguage!==E (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\2Player\English\")
			if /I !HUDLanguage!==F (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\2Player\French\")
			if /I !HUDLanguage!==G (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\2Player\German\")
			if /I !HUDLanguage!==I (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\2Player\Italian\")
			if /I !HUDLanguage!==K (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\2Player\Korean\")
			if /I !HUDLanguage!==S (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\2Player\Spanish\")
		)		
		
		REM TYPE CHAOTIX
		if /I !HUDType!==C (
			if /I !FileName!==game_dispC (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamChaotix\")
			if /I !HUDLanguage!==E (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamChaotix\English\")
			if /I !HUDLanguage!==F (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamChaotix\French\")
			if /I !HUDLanguage!==G (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamChaotix\German\")
			if /I !HUDLanguage!==I (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamChaotix\Italian\")
			if /I !HUDLanguage!==K (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamChaotix\Korean\")
			if /I !HUDLanguage!==S (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamChaotix\Spanish\")
		)		
		
		REM TYPE DARK
		if /I !HUDType!==D (
			if /I !FileName!==game_dispD (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamDark\")
			if /I !HUDLanguage!==E (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamDark\English\")
			if /I !HUDLanguage!==F (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamDark\French\")
			if /I !HUDLanguage!==G (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamDark\German\")
			if /I !HUDLanguage!==I (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamDark\Italian\")
			if /I !HUDLanguage!==K (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamDark\Korean\")
			if /I !HUDLanguage!==S (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamDark\Spanish\")
		)
		
		REM TYPE ROSE
		if /I !HUDType!==R (
			if /I !FileName!==game_dispR (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamRose\")
			if /I !HUDLanguage!==E (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamRose\English\")
			if /I !HUDLanguage!==F (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamRose\French\")
			if /I !HUDLanguage!==G (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamRose\German\")
			if /I !HUDLanguage!==I (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamRose\Italian\")
			if /I !HUDLanguage!==K (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamRose\Korean\")
			if /I !HUDLanguage!==S (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\TeamRose\Spanish\")
		)
	)
	
	if /I !ResultIdentifier!==result (
		REM RESULT TYPE A, NORMAL MODE
		if /I !ResultType!==A (
			if /I !FileName!==resultA_disp (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\Normal\")
			if /I !HUDLanguage!==F (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\Normal\French\")
			if /I !HUDLanguage!==G (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\Normal\German\")
			if /I !HUDLanguage!==I (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\Normal\Italian\")
			if /I !HUDLanguage!==S (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\Normal\Spanish\")
		)		
		REM RESULT TYPE B, TIME ONLY
		if /I !ResultType!==B (
			if /I !FileName!==resultB_disp (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\TimeOnly\")
			if /I !HUDLanguage!==F (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\TimeOnly\French\")
			if /I !HUDLanguage!==G (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\TimeOnly\German\")
			if /I !HUDLanguage!==I (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\TimeOnly\Italian\")
			if /I !HUDLanguage!==S (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\TimeOnly\Spanish\")
		)		
		REM RESULT TYPE S, BONUS STAGE
		if /I !ResultType!==S (
			if /I !FileName!==resultS_disp (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\BonusStage\")
			if /I !HUDLanguage!==F (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\BonusStage\French\")
			if /I !HUDLanguage!==G (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\BonusStage\German\")
			if /I !HUDLanguage!==I (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\BonusStage\Italian\")
			if /I !HUDLanguage!==S (move /Y %%f "%WORKING_DIRECTORY%\ROM\HUD\ResultsScreen\BonusStage\Spanish\")
		)
	)
)


rem
rem Sort out what is left in the ROOTDIR. Misc preprogrammed actions.
rem
mkdir "%WORKING_DIRECTORY%\ROM\Unknown\Group1\"

for %%f in (%WORKING_DIRECTORY%\ROM\*) do (
	set FileName=%%~nf
	set CoverIdentifier=!FileName:~0,9!
	set StartbtnIdentifier=!FileName:~0,8!
	set CoverLanguage=!FileName:~9,2!
	set StartbtnLanguage=!FileName:~9,2!
	
	set 3Chars=!FileName:~0,3!

	if /I !CoverIdentifier!==coverOpen (
		if /I !FileName!==coverOpen (mkdir "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\Unknown\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\Unknown\")
		if /I !CoverLanguage!==en (mkdir "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\English\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\English\")
		if /I !CoverLanguage!==fr (mkdir "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\French\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\French\")
		if /I !CoverLanguage!==ge (mkdir "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\German\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\German\")
		if /I !CoverLanguage!==it (mkdir "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\Italian\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\Italian\")
		if /I !CoverLanguage!==jp (mkdir "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\Japanese\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\Japanese\")
		if /I !CoverLanguage!==ko (mkdir "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\Korean\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\Korean\")
		if /I !CoverLanguage!==sp (mkdir "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\Spanish\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\Spanish\")
	)	
	
	if /I !StartbtnIdentifier!==startbtn (
		if /I !StartbtnLanguage!==en (mkdir "%WORKING_DIRECTORY%\ROM\Other\TitleScreenStartButtonAnimation\English\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\TitleScreenStartButtonAnimation\English\")
		if /I !StartbtnLanguage!==fr (mkdir "%WORKING_DIRECTORY%\ROM\Other\TitleScreenStartButtonAnimation\French\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\TitleScreenStartButtonAnimation\French\")
		if /I !StartbtnLanguage!==ge (mkdir "%WORKING_DIRECTORY%\ROM\Other\TitleScreenStartButtonAnimation\German\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\TitleScreenStartButtonAnimation\German\")
		if /I !StartbtnLanguage!==it (mkdir "%WORKING_DIRECTORY%\ROM\Other\TitleScreenStartButtonAnimation\Italian\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\TitleScreenStartButtonAnimation\Italian\")
		if /I !StartbtnLanguage!==jp (mkdir "%WORKING_DIRECTORY%\ROM\Other\TitleScreenStartButtonAnimation\Japanese\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\TitleScreenStartButtonAnimation\Japanese\")
		if /I !StartbtnLanguage!==ko (mkdir "%WORKING_DIRECTORY%\ROM\Other\TitleScreenStartButtonAnimation\Korean\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\TitleScreenStartButtonAnimation\Korean\")
		if /I !StartbtnLanguage!==sp (mkdir "%WORKING_DIRECTORY%\ROM\Other\TitleScreenStartButtonAnimation\Spanish\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\TitleScreenStartButtonAnimation\Spanish\")
	)
	
	if /I !FileName!==opening (mkdir "%WORKING_DIRECTORY%\ROM\Other\GameCubeBanner\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\GameCubeBanner\")
	if /I !FileName!==pk1_par1 (mkdir "%WORKING_DIRECTORY%\ROM\Unused\SeasideHillGiantBirdTexture\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Unused\SeasideHillGiantBirdTexture\")
	if /I !FileName!==mte_gcn (mkdir "%WORKING_DIRECTORY%\ROM\Other\GameCubeMaterialDefinitions\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\GameCubeMaterialDefinitions\")
	if /I !FileName!==startLoad (mkdir "%WORKING_DIRECTORY%\ROM\Other\LoadingLogoOnGameLaunch\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\LoadingLogoOnGameLaunch\")
	if /I !FileName!==loading (mkdir "%WORKING_DIRECTORY%\ROM\Other\TeamBattle~E3ProtoLoadAnimation\" && move /Y %%f "%WORKING_DIRECTORY%\ROM\Other\TeamBattle~E3ProtoLoadAnimation\")
	
	if /I !3Chars!==mc_ (move /Y %%f "%WORKING_DIRECTORY%\ROM\Unknown\Group1\")
)

rem
rem HeroesONE goes Harambe! AYAYAYAYAYAYAY!!!
rem
cd %WORKING_DIRECTORY%\ROM\
for /R %%f in ("*.one") do (
	echo "HeroesONE: Extracting %%~nxf"
for /R %%f in ("*.one") do (DEL /F "%%f")

rem Protect Weird .one files from HeroesONE and Removal 2
for /D %%d in (%WORKING_DIRECTORY%\ROM\Other\OpenDiscTrayMessage\*) do (
	for %%f in (%%d\*.tmp) do (
		cd %%d
		ren "%%~nxf" "%%~nf"
	)
)

rem
rem Cleanup
rem

rem Remove Useless Microsoft Sourcesafe Leftovers
for /R %%f in ("*") do ( 
	if /I %%~nxf==vssver.scc (DEL /F %%f) 
)

rem Kill Empty Directories
cd %WORKING_DIRECTORY%\ROM\
for /f "usebackq delims=" %%d in (`"dir /ad/b/s | sort /R"`) do rd "%%d"

rem ALL HAIL MARKEYJESTER
rem ALL HAIL MARKEYJESTER
rem ALL HAIL MARKEYJESTER
echo "DONE"
pause