:: turn off "echoing" of commands
@echo off
:: set the size of the window
@mode con cols=53 lines=24
:: set color to black background, white text
color 07

:: x will be a string which contains padding for x direction
set "x="
:: y will be an integer for the for loop which prints echo. on loop
set "y="
:: prevChoice represents the previous input
set "prevChoice=d"
:: the thing that will be moving around
set "head=@"

:: a sort of point or marker where you can jump back to
:mainLoop

  :: clear the screen
  cls

  :: for loop, % signs are used to actually use a variable among other things
  for /l %%a in ( 0, 1, %y% ) do echo.
  ::do x axis
  echo %x%%head%

  :: choice command, allows for input without asking for an \n
  :: /c flag used to specify choices, /n flag used to say no output from command
  :: /t is the timeout on the choice command waiting for input
  :: /d is the default choice if the command times out
  :: choice sets the errorlevel variable
  choice /c wasd /n /t 1 /d %prevChoice%

  :: equ used for == or equals operation
  :: goto is used to call or go to a :point
  if %errorlevel% equ 4 goto moveRight
  if %errorlevel% equ 3 goto moveDown
  if %errorlevel% equ 2 goto moveLeft
  if %errorlevel% equ 1 goto moveUp

:moveRight
  set "prevChoice=d"

  :: sets length to the previous variable length plus a space
  :: the carrot sign is used to "escape" the space
  set "x= %x%"

  :: go back to the main gameloop
  goto mainLoop

:moveDown
  set "prevChoice=s"

  :: /a flag is used to denote there will be an operation
  set /a "y+=1"

  goto mainLoop

:moveLeft
  set "prevChoice=a"

  :: do some string slicing and check to make sure character doesn't go too far left
  if "%x%" neq "" set "x=%x:~0,-1%"

  goto mainLoop

:moveUp
  set "prevChoice=w"

  :: /a flag is used to denote there will be an operation
  set /a "y-=1"

  goto mainLoop
