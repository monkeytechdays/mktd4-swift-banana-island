# mktd4-swift-banana-island

## Installation

Download this repository as a ZIP.

## Preparation

### MKTData 

This is the main libray used by the player - a backend server - and the 
viewer - the iOS application.

#### Build and check the library

```
$ swift build
$ swift test
```

#### Tag version 

This operation is mandatory and required by the Swift dependency model.

```
$ git init .
$ git add .
$ git commit -m "First init"
$ git tag 1.0.0 -m "v1.0.0"
```

Therefor this library can be used a dependency.

### MKTViewer

This compoment shows the current game hosted by the referee server.

#### Update the dependency

```
$ swift package update
```

#### Open the project

```
$ open MKTViewer.xcodeproj
```

This command starts XCode. Then open `BananaMaze/GameService.swift`. The request to the 
main server must be implemented. For this purpose you already a class `Game` provided
by the MKTData libray.

### MKTPlayer

This is the component able to compute the next direction on-demand.

#### Build and check the server

```
$ swift build
$ swift test
```

#### Start the server

Starting the server requires a configuration file. Some models are available in the `etc` directory.

```
$ .build/debug/MKTPlayerRunner etc/alouate.json 
[2017-05-11T11:33:20.917+02:00] [VERBOSE] [Router.swift:67 init(mergeParameters:)] Router initialized
[2017-05-11T11:33:21.002+02:00] [INFO] [main.swift:76 MKTPlayerRunner] Registration accepted with team identifier 3
[2017-05-11T11:33:21.003+02:00] [VERBOSE] [Kitura.swift:70 run()] Starting Kitura framework...
[2017-05-11T11:33:21.003+02:00] [VERBOSE] [Kitura.swift:80 start()] Starting an HTTP Server on port 9091...
[2017-05-11T11:33:21.003+02:00] [INFO] [HTTPServer.swift:88 listen(on:)] Listening on port 9091
```

#### Heuristic

Build now your own heuristic. For more information check and analyze the `RandomHeuristic` class. This class can 
be modified or a new one can be proposed. Don't forget to inject the chosen heuristic in the `main.swift` boot
file.

## License

Copyright (C)2017 D. Plaindoux.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this program; see the file COPYING. If not, write to the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
