# StarterPlayerScripts
- I am going to read through `StarterPlayerScripts` to get a better idea of how ROBLOX runs everything under the hood.
- Either this will go great or horrible or I'll quit. Hopefully I won't quit.
- Anyways here is where I will put my quick reference, my guide. We Pray.
- This is going by loose Breadth First Search.
    - I will generate a type annotation of a module, then I will add all unfamiliar terms to a queue in the order they appear (well, as close as I can without it making no sense)
    - I will then generate type annotations for the first item in the queue, again adding unfamiliar terms to the back of the queue.
    - Repeat until I've crawled through the whole of `StarterPlayerScripts` or died trying.

# PlayerScripts
- An Instance, not a script.
- Has [roblox documentation](https://create.roblox.com/docs/reference/engine/classes/PlayerScripts#RegisterComputerCameraMovementMode) too so don't even trip

# PlayerModule/init.luau
- Represents a player (has a camera and controls).
- The module script itself returns `PlayerModule.new()`, which is strange.

## Fields
- `cameras: CameraModule`
- `controls: ControlModule`

## Methods
- `new(): PlayerModule` (STATIC)
---
- `GetCameras(self: PlayerModule): CameraModule`
- `GetControls(self: PlayerModule): ControlModule`
- `GetClickToMoveController(self: PlayerModule): typeof(self.controls:GetClickToMoveController())`

# PlayerModule/CameraModule/init.luau
- Handles all the players' camera controls.
- Will throw an error if run on the server (asserts that Players.LocalPlayer must exist).
- Adds all Control Modes and Camera Modes to the Roblox User Settings screen (Esc)
- TODO: There are also some FFlags which idk about ig i'll come back to it

## Types
- there will probably be types for this later. lol!
- `type Generic = any`
- `type GenericOptional = any?`

## Fields
- `PLAYER_CAMERA_PROPERTIES: {}` (PRIVATE STATIC)
```
"CameraMinZoomDistance",
"CameraMaxZoomDistance",
"CameraMode",
"DevCameraOcclusionMode",
"DevComputerCameraMode",
"DevTouchCameraMode",

-- Character movement mode
"DevComputerMovementMode",
"DevTouchMovementMode",
"DevEnableMouseLock",
```

- `USER_GAME_SETTINGS_PROPERTIES: {}` (PRIVATE STATIC)
```
"ComputerCameraMovementMode",
"ComputerMovementMode",
"ControlMode",
"GamepadCameraSensitivity",
"MouseSensitivity",
"RotationType",
"TouchCameraMovementMode",
"TouchMovementMode",
```

- `activeCameraController: GenericOptional`
- `activeMouseLockController: GenericOptional`
- `activeOcclusionModule: GenericOptional`
- `activeTransparencyController: Generic`
- `cameraSubjectChangedConn: RBXScriptConnection?`
- `cameraTypeChangedConn: RBXScriptConnection?`
- `connectionUtil: ConnectionUtil.ConnectionUtil?`
- `currentComputerCameraMovementMode: Enum.ComputerCameraMovementMode? | Enum.DevComputerCameraMovementMode?`
- `occlusionMode: Enum.DevCameraOcclusionMode?`

## Methods
- `new(): CameraModule` (STATIC)
    - Standard `new()` function. Instantiates a bunch of classes, toggles certain parts of the code based on your FFlags (whatever that means), and creates a bunch of connections tying the lifespan of the instantiated stuff to the player and certain actions they can take (like plugging in a controller or switching camera type in menu)
- `ActivateCameraController(self: CameraModule) -> (),`
- `ActivateOcclusionModule(self: CameraModule, occlusionMode: Enum.DevCameraOcclusionMode) -> (),`
- `GetCameraMovementModeFromSettings(self: CameraModule) -> Enum.ComputerCameraMovementMode | Enum.DevComputerCameraMovementMode,`
- `OnPreferredInputChanged(self: CameraModule) -> (),`
- `OnCameraSubjectChanged(self: CameraModule) -> (),`
- `OnCameraTypeChanged(self: CameraModule, newCameraType: Enum.CameraType) -> (),`
- `OnCharacterAdded(self: CameraModule, character: Model, player: Player) -> (),`
- `OnCharacterRemoving(self: CameraModule, character: Model, player: Player) -> (),`
- `OnCurrentCameraChanged(self: CameraModule) -> (),`
- `OnLocalPlayerCameraPropertyChanged(self: CameraModule, propertyName: string) -> (),`
- `OnPlayerAdded(self: CameraModule, player: Player) -> (),`
- `OnPlayerRemoving(self: CameraModule, player: Player) -> (),`
- `OnMouseLockToggled(self: CameraModule) -> (),`
- `OnUserGameSettingsPropertyChanged(self: CameraModule, propertyName: string) -> (),`
- `ShouldUseVehicleCamera(self: CameraModule) -> boolean,`
- `Update(self: CameraModule, dt: number) -> (),`

# PlayerModule/CameraModule/CameraUtils.luau
# PlayerModule/CameraModule/CameraInput.luau
# PlayerModule/CameraModule/ClassicCamera.luau
# PlayerModule/CameraModule/OrbitalCamera.luau
# PlayerModule/CameraModule/LegacyCamera.luau
# PlayerModule/CameraModule/VehicleCamera.luau
# PlayerModule/CameraModule/VRCamera.luau
# PlayerModule/CameraModule/VRVehicleCamera.luau
# PlayerModule/CameraModule/Invisicam.luau
# PlayerModule/CameraModule/Poppercam.luau
# PlayerModule/CameraModule/TransparencyController.luau
# PlayerModule/CameraModule/MouseLockController.luau

# PlayerModule/ControlModule/init.luau

# PlayerModule/CommonUtils/CameraWrapper.luau
# PlayerModule/CommonUtils/CharacterUtil.luau
# PlayerModule/CommonUtils/ConnectionUtil.luau
# PlayerModule/CommonUtils/FlagUtil.luau
