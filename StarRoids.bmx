
Strict

' ideas - big and small alien spaceship
' 		  little ships give power-ups: double shot ship, triple shot ship,..
'         4 way shot? smart bomb - will need shader to look good, hyperspace - hmm not sure

' for high score table. move to other side of planet? spin the camera around?

Import pub.win32
Import srs.directx11

Const RENDERFLAG_SOLID:Int = 1
Const RENDERFLAG_WIREFRAME:Int = 2

Type tMeshData	
	Method shipWireframe:String()
		Local mesh:String
		mesh :+ "linestrip~n"
		mesh :+ "v -0.5 -0.8 0.0~n"
		mesh :+ "v 0.0 0.8 0.0~n"
		mesh :+ "v 0.5 -0.8 0.0~n"
		mesh :+ "v 0.25 -0.5 0.0~n"
		mesh :+ "v -0.25 -0.5 0.0~n"
		mesh :+ "v 0.0 0.2 0.0~n"
		mesh :+ "v 0.0 -0.3 0.0~n"
		mesh :+ "f 0 1 2 3 4 0 -1 5 6"
		
		Return mesh
	EndMethod
	
	Method shipSolid:String()
		Local mesh:String
		mesh :+ "trianglelist~n"
		mesh :+ "v -0.5 -0.8 0.0~n"
		mesh :+ "v 0.0 0.8 0.0~n"
		mesh :+ "v 0.5 -0.8 0.0~n"
		mesh :+ "v 0.25 -0.5 0.0~n"
		mesh :+ "v -0.25 -0.5 0.0~n"
		mesh :+ "v 0.0 0.2 0.0~n"
		mesh :+ "v 0.0 -0.3 0.0~n"
		mesh :+ "f 0 1 4 4 1 3 3 1 2"
		
		Return mesh
	EndMethod
	
	Method shipUpgradedWireframe:String()
		Local mesh:String
		mesh :+ "linelist~n"
		mesh :+ "v -2.0 -4 0.0~n"
		mesh :+ "v -2.0 1.0 0.0~n"
		mesh :+ "v 2.0 1.0 0.0~n"
		mesh :+ "v 2.0 -4 0.0~n"
		mesh :+ "v -6.0 -3.0 0.0~n"
		mesh :+ "v -6.0 -1.0 0.0~n"
		mesh :+ "v -2.0 0.0 0.0~n"
		mesh :+ "v 6.0 -3.0 0.0~n"
		mesh :+ "v 6.0 -1.0 0.0~n"
		mesh :+ "v 2.0 0.0 0.0~n"
		mesh :+ "v -1.0 5.0 0.0~n"
		mesh :+ "v 1.0 5.0 0.0~n"
		mesh :+ "v -1.25 4.0 0.0~n"
		mesh :+ "v -2.9 3.25 0.0~n"
		mesh :+ "v -2.9 2.25 0.0~n"
		mesh :+ "v -1.75 2.0 0.0~n"
		mesh :+ "v 1.25 4.0 0.0~n"
		mesh :+ "v 2.9 3.25 0.0~n"
		mesh :+ "v 2.9 2.25 0.0~n"
		mesh :+ "v 1.75 2.0 0.0~n"
		mesh :+ "f 0 1 1 2 2 3 3 0~n"
		mesh :+ "f 0 4 4 5 5 6~n"
		mesh :+ "f 3 7 7 8 8 9~n"
		mesh :+ "f 1 10 10 11 11 2~n"
		
		mesh :+ "f 12 13 13 14 14 15~n"
		mesh :+ "f 16 17 17 18 18 19~n"
		
		Return mesh
	EndMethod
	
	Method shipUpgradedSolid:String()
		Local mesh:String
		mesh :+ "trianglelist~n"
		mesh :+ "v -2.0 -4 0.0~n"
		mesh :+ "v -2.0 1.0 0.0~n"
		mesh :+ "v 2.0 1.0 0.0~n"
		mesh :+ "v 2.0 -4 0.0~n"
		
		mesh :+ "v -6.0 -3.0 0.0~n"
		mesh :+ "v -6.0 -1.0 0.0~n"
		
		mesh :+ "v -2.0 0.0 0.0~n"
		mesh :+ "v 6.0 -3.0 0.0~n"
		mesh :+ "v 6.0 -1.0 0.0~n"
		mesh :+ "v 2.0 0.0 0.0~n"
		mesh :+ "v -1.0 5.0 0.0~n"
		mesh :+ "v 1.0 5.0 0.0~n"
		mesh :+ "v -1.25 4.0 0.0~n"
		mesh :+ "v -2.9 3.25 0.0~n"
		mesh :+ "v -2.9 2.25 0.0~n"
		mesh :+ "v -1.75 2.0 0.0~n"
		mesh :+ "v 1.25 4.0 0.0~n"
		mesh :+ "v 2.9 3.25 0.0~n"
		mesh :+ "v 2.9 2.25 0.0~n"
		mesh :+ "v 1.75 2.0 0.0~n"
		mesh :+ "f 0 1 2 0 2 3~n"
		mesh :+ "f 4 5 6 4 6 0~n"
		mesh :+ "f 3 9 7 7 9 8~n"
		mesh :+ "f 1 10 2 2 10 11~n"
		mesh :+ "f 14 13 12 14 12 15~n"
		mesh :+ "f 19 16 17 19 17 18"
		
		Return mesh
	EndMethod


	Method powerupShipSolid:String()
		Local mesh:String
		mesh :+ "trianglelist~n"
		mesh :+ "v -2.5 -2.5 -2.5~n"
		mesh :+ "v -2.5 2.5 -2.5~n"
		mesh :+ "v 2.5 2.5 -2.5~n"
		mesh :+ "v 2.5 -2.5 -2.5~n"
		mesh :+ "v -2.5 -2.5 2.5~n"
		mesh :+ "v -2.5 2.5 2.5~n"
		mesh :+ "v 2.5 2.5 2.5~n"
		mesh :+ "v 2.5 -2.5 2.5~n"

		mesh :+ "f 0 1 2 0 2 3~n"
		mesh :+ "f 3 2 6 3 6 7~n"
		mesh :+ "f 4 5 1 4 1 0~n"
		mesh :+ "f 7 6 5 7 5 4~n"
		mesh :+ "f 4 0 3 4 3 7~n"
		mesh :+ "f 1 5 2 2 5 6~n"

		Return mesh
	EndMethod

	Method powerupShipWireframe:String()
		Local mesh:String
		mesh :+ "linelist~n"
		mesh :+ "v -2.5 -2.5 -2.5~n"
		mesh :+ "v -2.5 2.5 -2.5~n"
		mesh :+ "v 2.5 2.5 -2.5~n"
		mesh :+ "v 2.5 -2.5 -2.5~n"
		mesh :+ "v -2.5 -2.5 2.5~n"
		mesh :+ "v -2.5 2.5 2.5~n"
		mesh :+ "v 2.5 2.5 2.5~n"
		mesh :+ "v 2.5 -2.5 2.5~n"
		mesh :+ "f 0 1 1 2 2 3 3 0 -1~n"
		mesh :+ "f 3 2 2 6 6 7 7 3 -1~n"
		mesh :+ "f 4 5 5 6 6 7 7 4 -1~n"
		mesh :+ "f 0 1 1 5 5 4 4 0 -1~n"
		
		mesh :+ "v -0.6 -1.2 2.5~n"
		mesh :+ "v -0.6 0.3 2.5~n"
		mesh :+ "v 0.6 0.3 2.5~n"
		mesh :+ "v 0.6 -1.2 2.5~n"
		mesh :+ "v -1.8 -0.9 2.5~n"
		mesh :+ "v -1.8 -0.3 2.5~n"
		mesh :+ "v -0.6 0.0 2.5~n"
		mesh :+ "v 1.8 -0.9 2.5~n"
		mesh :+ "v 1.8 -0.3 2.5~n"
		mesh :+ "v 0.6 0.0 2.5~n"
		mesh :+ "v -0.3 1.5 2.5~n"
		mesh :+ "v 0.3 1.5 2.5~n"
		mesh :+ "v -0.375 1.2 2.5~n"
		mesh :+ "v -0.87 0.975 2.5~n"
		mesh :+ "v -0.87 0.675 2.5~n"
		mesh :+ "v -0.525 0.6 2.5~n"
		mesh :+ "v 0.375 1.2 2.5~n"
		mesh :+ "v 0.87 0.975 2.5~n"
		mesh :+ "v 0.87 0.675 2.5~n"
		mesh :+ "v 0.525 0.6 2.5~n"
		
		mesh :+ "f 8 9 9 10 10 11 11 8~n"
		mesh :+ "f 8 12 12 13 13 14~n"
		mesh :+ "f 11 15 15 16 16 17~n"
		mesh :+ "f 9 18 18 19 19 10~n"
		mesh :+ "f 20 21 21 22 22 23~n"
		mesh :+ "f 24 25 25 26 26 27~n"
		
		mesh :+ "v -0.6 -1.2 -2.5~n"
		mesh :+ "v -0.6 0.3 -2.5~n"
		mesh :+ "v 0.6 0.3 -2.5~n"
		mesh :+ "v 0.6 -1.2 -2.5~n"
		mesh :+ "v -1.8 -0.9 -2.5~n"
		mesh :+ "v -1.8 -0.3 -2.5~n"
		mesh :+ "v -0.6 0.0 -2.5~n"
		mesh :+ "v 1.8 -0.9 -2.5~n"
		mesh :+ "v 1.8 -0.3 -2.5~n"
		mesh :+ "v 0.6 0.0 -2.5~n"
		mesh :+ "v -0.3 1.5 -2.5~n"
		mesh :+ "v 0.3 1.5 -2.5~n"
		mesh :+ "v -0.375 1.2 -2.5~n"
		mesh :+ "v -0.87 0.975 -2.5~n"
		mesh :+ "v -0.87 0.675 -2.5~n"
		mesh :+ "v -0.525 0.6 -2.5~n"
		mesh :+ "v 0.375 1.2 -2.5~n"
		mesh :+ "v 0.87 0.975 -2.5~n"
		mesh :+ "v 0.87 0.675 -2.5~n"
		mesh :+ "v 0.525 0.6 -2.5~n"
		
		mesh :+ "f 28 29 29 30 30 31 31 28~n"
		mesh :+ "f 28 32 32 33 33 34~n"
		mesh :+ "f 31 35 35 36 36 37~n"
		mesh :+ "f 29 38 38 39 39 30~n"
		mesh :+ "f 40 41 41 42 42 43~n"
		mesh :+ "f 44 45 45 46 46 47~n"
		
		mesh :+ "v -2.5 -1.2 -0.6~n"
		mesh :+ "v -2.5 0.3 -0.6~n"
		mesh :+ "v -2.5 0.3 0.6~n"
		mesh :+ "v -2.5 -1.2 0.6~n"
		mesh :+ "v -2.5 -0.9 -1.8~n"
		mesh :+ "v -2.5 -0.3 -1.8~n"
		mesh :+ "v -2.5 0.0 -0.6~n"
		mesh :+ "v -2.5 -0.9 1.8~n"
		mesh :+ "v -2.5 -0.3 1.8~n"
		mesh :+ "v -2.5 0.0 0.6~n"
		mesh :+ "v -2.5 1.5 -0.3~n"
		mesh :+ "v -2.5 1.5 0.3~n"
		mesh :+ "v -2.5 1.2 -0.375~n"
		mesh :+ "v -2.5 0.975 -0.87~n"
		mesh :+ "v -2.5 0.675 -0.87~n"
		mesh :+ "v -2.5 0.6 -0.525~n"
		mesh :+ "v -2.5 1.2 0.375~n"
		mesh :+ "v -2.5 0.975 0.87~n"
		mesh :+ "v -2.5 0.675 0.87~n"
		mesh :+ "v -2.5 0.6 0.525~n"
		
		mesh :+ "f 48 49 49 50 50 51 51 48~n"
		mesh :+ "f 48 52 52 53 53 54~n"
		mesh :+ "f 51 55 55 56 56 57~n"
		mesh :+ "f 49 58 58 59 59 50~n"
		mesh :+ "f 60 61 61 62 62 63~n"
		mesh :+ "f 64 65 65 66 66 67~n"
		
		mesh :+ "v 2.5 -1.2 -0.6~n"
		mesh :+ "v 2.5 0.3 -0.6~n"
		mesh :+ "v 2.5 0.3 0.6~n"
		mesh :+ "v 2.5 -1.2 0.6~n"
		mesh :+ "v 2.5 -0.9 -1.8~n"
		mesh :+ "v 2.5 -0.3 -1.8~n"
		mesh :+ "v 2.5 0.0 -0.6~n"
		mesh :+ "v 2.5 -0.9 1.8~n"
		mesh :+ "v 2.5 -0.3 1.8~n"
		mesh :+ "v 2.5 0.0 0.6~n"
		mesh :+ "v 2.5 1.5 -0.3~n"
		mesh :+ "v 2.5 1.5 0.3~n"
		mesh :+ "v 2.5 1.2 -0.375~n"
		mesh :+ "v 2.5 0.975 -0.87~n"
		mesh :+ "v 2.5 0.675 -0.87~n"
		mesh :+ "v 2.5 0.6 -0.525~n"
		mesh :+ "v 2.5 1.2 0.375~n"
		mesh :+ "v 2.5 0.975 0.87~n"
		mesh :+ "v 2.5 0.675 0.87~n"
		mesh :+ "v 2.5 0.6 0.525~n"
		
		mesh :+ "f 68 69 69 70 70 71 71 68~n"
		mesh :+ "f 68 72 72 73 73 74~n"
		mesh :+ "f 71 75 75 76 76 77~n"
		mesh :+ "f 69 78 78 79 79 70~n"
		mesh :+ "f 80 81 81 82 82 83~n"
		mesh :+ "f 84 85 85 86 86 87~n"
		
		mesh :+ "v 2.5 0.1 1.5~n"
		mesh :+ "v 2.5 0.6 1.5~n"
		mesh :+ "v 2.5 1.4 1.5~n"
		mesh :+ "v 2.5 1.9 1.5~n"
		mesh :+ "v 2.5 0.1 -1.5~n"
		mesh :+ "v 2.5 0.6 -1.5~n"
		mesh :+ "v 2.5 1.4 -1.5~n"
		mesh :+ "v 2.5 1.9 -1.5~n"
		mesh :+ "f 88 89 90 91 92 93 94 95~n"
		
		mesh :+ "v -2.5 0.1 1.5~n"
		mesh :+ "v -2.5 0.6 1.5~n"
		mesh :+ "v -2.5 1.4 1.5~n"
		mesh :+ "v -2.5 1.9 1.5~n"
		mesh :+ "v -2.5 0.1 -1.5~n"
		mesh :+ "v -2.5 0.6 -1.5~n"
		mesh :+ "v -2.5 1.4 -1.5~n"
		mesh :+ "v -2.5 1.9 -1.5~n"
		mesh :+ "f 96 97 98 99 100 101 102 103~n"

		mesh :+ "v 1.5 0.1 2.5~n"
		mesh :+ "v 1.5 0.6 2.5~n"
		mesh :+ "v 1.5 1.4 2.5~n"
		mesh :+ "v 1.5 1.9 2.5~n"
		mesh :+ "v -1.5 0.1 2.5~n"
		mesh :+ "v -1.5 0.6 2.5~n"
		mesh :+ "v -1.5 1.4 2.5~n"
		mesh :+ "v -1.5 1.9 2.5~n"
		mesh :+ "f 104 105 106 107 108 109 110 111~n"
		
		mesh :+ "v 1.5 0.1 -2.5~n"
		mesh :+ "v 1.5 0.6 -2.5~n"
		mesh :+ "v 1.5 1.4 -2.5~n"
		mesh :+ "v 1.5 1.9 -2.5~n"
		mesh :+ "v -1.5 0.1 -2.5~n"
		mesh :+ "v -1.5 0.6 -2.5~n"
		mesh :+ "v -1.5 1.4 -2.5~n"
		mesh :+ "v -1.5 1.9 -2.5~n"
		mesh :+ "f 112 113 114 115 116 117 118 119"


		Return mesh
	EndMethod
	
	Method galacticBomb:String()
		Local mesh:String
		Return mesh
	EndMethod

	Method bulletWireframe:String()
		Local mesh:String
		mesh :+ "linelist~n"
		mesh :+ "v -0.03 -0.03 0.0~n"
		mesh :+ "v -0.03 0.03 0.0~n"
		mesh :+ "v 0.03 0.03 0.0~n"
		mesh :+ "v 0.03 -0.03 0.0~n"
		mesh :+ "f 0 1 2 3 0~n"
		
		Return mesh
	EndMethod
	
	Method alienBulletWireframe:String()
		Local mesh:String
		mesh :+ "linelist~n"
		mesh :+ "v -1.0 0.0 0.0~n"
		mesh :+ "v 1.0 0.0 0.0~n"
		mesh :+ "v 0.0 -1.0 0.0~n"
		mesh :+ "v 0.0 1.0 0.0~n"
		mesh :+ "v 0.0 0.0 -1.0~n"
		mesh :+ "v 0.0 0.0 1.0~n"
		mesh :+ "f 0 1 2 3 4 5"
		
		Return mesh
	EndMethod

	Method alienBigWireframe:String()
		Local mesh:String
		mesh :+ "linelist~n"
		mesh :+ "v 0.0 0.0 1.0~n"
		mesh :+ "v 0.2 0.1 0.77~n"
		mesh :+ "v 0.38 -0.1 1.44~n"
		mesh :+ "v 0.49 0.0 0.86~n"
		
		mesh :+ "v 0.7 0.0 0.7~n"
		mesh :+ "v 0.69 0.1 0.4~n"
		mesh :+ "v 1.29 -0.1 0.75~n"
		mesh :+ "v 0.96 0.0 0.25~n"
		
		mesh :+ "v 1.0 0. 0.0 ~n"
		mesh :+ "v 0.77 0.1 -0.2~n"
		mesh :+ "v 1.44 -0.1 -0.38~n"
		mesh :+ "v 0.86 0.0 -0.49~n"
		
		mesh :+ "v 0.7 0.0 -0.7~n"
		mesh :+ "v 0.39 0.1 -0.66~n"
		mesh :+ "v 0.75 -0.1 -1.29~n"
		mesh :+ "v 0.35 0.0 -0.96~n"

		mesh :+ "v 0.0 0.0 -1.0~n"
		mesh :+ "v -0.2 0.1 -0.77~n"
		mesh :+ "v -0.38 -0.1 -1.44~n"
		mesh :+ "v -0.5 0.0 -0.86~n"
		
		mesh :+ "v -0.7 0.0 -0.7~n"
		mesh :+ "v -0.69 0.1 -0.4~n"
		mesh :+ "v -1.29 -0.1 -0.75~n"
		mesh :+ "v -0.96 0.0 -0.25~n"
		
		mesh :+ "v -1.0 0.0 0.0~n"
		mesh :+ "v -0.77 0.1 0.2~n"
		mesh :+ "v -1.44 -0.1 0.38~n"
		mesh :+ "v -0.86 0.0 0.5~n"
		
		mesh :+ "v -0.7 0.0 0.7~n"
		mesh :+ "v -0.4 0.1 0.69~n"
		mesh :+ "v -0.75 -0.1 1.29~n"
		mesh :+ "v -0.25 0.0 0.96~n"
		
		mesh :+ "f 0 1 1 3 3 2 2 0~n"
		mesh :+ "f 4 5 5 7 7 6 6 4~n"
		mesh :+ "f 8 9 9 11 11 10 10 8"
		mesh :+ "f 12 13 13 15 15 14 14 12~n"
		mesh :+ "f 16 17 17 19 19 18 18 16~n"
		mesh :+ "f 20 21 21 23 23 22 22 20~n"
		mesh :+ "f 24 25 25 27 27 26 26 24~n"
		mesh :+ "f 28 29 29 31 31 30 30 28~n"
		
		mesh :+ "f 3 4 7 8 11 12 15 16 19 20 23 24 27 28 31 0~n"
		mesh :+ "f 1 5 5 9 9 13 13 17 17 21 21 25 25 29 29 1~n"
		
		mesh :+ "v 0.38 -0.2 1.44~n"
		mesh :+ "v 1.29 -0.2 0.75~n"
		mesh :+ "v 1.44 -0.2 -0.38~n"
		mesh :+ "v 0.75 -0.2 -1.29~n"
		mesh :+ "v -0.38 -0.2 -1.44~n"
		mesh :+ "v -1.29 -0.2 -0.75~n"
		mesh :+ "v -1.44 -0.2 0.38~n"
		mesh :+ "v -0.75 -0.2 1.29~n"
		'mesh :+ "f 2 32 6 33 10 34 14 35 18 36 22 37 26 38 30 39~n"
		
		'mesh :+ "f 32 33 33 34"
		
		Return mesh
	EndMethod
EndType

Type tAsteroid	
	Method Create:String()
		Local s:Float = (1.0 - Sqr(5.0)) / 2.0
		Local t:Float = (1.0 + Sqr(5.0)) / 2.0

		Local meshdata:String = "trianglelist~n"
		meshdata :+ "v -1.0 " + t + " 0.0~n"
		meshdata :+ "v 1.0 " + t + " 0.0~n"
		meshdata :+ "v -1.0 " + -t + " 0.0~n"
		meshdata :+ "v 1.0 " + -t + " 0.0~n"

		meshdata :+ "v 0.0 -1.0 " + t + "~n"
		meshdata :+ "v 0.0 1.0 " + t + "~n"
		meshdata :+ "v 0.0 -1.0 " + -t + "~n"
		meshdata :+ "v 0.0 1.0 " + -t + "~n"

		meshdata :+ "v " + t + " 0.0 -1.0~n"
		meshdata :+ "v " + t + " 0.0 1.0~n"
		meshdata :+ "v " + -t + " 0.0 -1.0~n"
		meshdata :+ "v " + -t + " 0.0 1.0~n"

		meshdata :+ "f 0 11 5~n"
		meshdata :+ "f 0 5 1~n"
		meshdata :+ "f 0 1 7~n"
		meshdata :+ "f 0 7 10~n"
		meshdata :+ "f 0 10 11~n"
		
		meshdata :+ "f 1 5 9~n"
		meshdata :+ "f 5 11 4~n"
		meshdata :+ "f 11 10 2~n"
		meshdata :+ "f 10 7 6~n"
		meshdata :+ "f 7 1 8~n"
		
		meshdata :+ "f 3 9 4~n"
		meshdata :+ "f 3 4 2~n"
		meshdata :+ "f 3 2 6~n"
		meshdata :+ "f 3 6 8~n"
		meshdata :+ "f 3 8 9~n"
		
		meshdata :+ "f 4 9 5~n"
		meshdata :+ "f 2 4 11~n"
		meshdata :+ "f 6 2 10~n"
		meshdata :+ "f 8 6 7~n"
		meshdata :+ "f 9 8 1"

		Return meshdata
	EndMethod
EndType

Type tAsteroidBelt
	Method CreateOuter:String()
		Local radius:Float = 19
		Local ringsize:Float = 2
		
		Local meshdata:String = "pointlist~n"

		For Local ang:Float = 0.0 Until 360.0
			Local random:Float = Rnd(-ringsize * 0.5, ringsize * 0.5)
			Local randomradius:Float = radius + random

			Local posx:Float = randomradius * Sin(ang)
			Local posy:Float = randomradius * Cos(ang)
			Local posz:Float = Rnd(-ringsize * 0.25, ringsize * 0.25)
			meshdata :+ "v " + posx + " " + posy + " " + posz + "~n"
		Next
		
		meshdata :+ "f"
		For Local i:Int = 0 Until 360
			meshdata :+ " " + i
		Next

		Return meshdata
	EndMethod
	
	Method createInner:String()
		Local radius:Float = 19
		Local ringsize:Float = 2
		
		Local meshdata:String = "pointlist~n"

		For Local ang:Float = 0.0 Until 360.0 Step 0.2
			Local random:Float = Rnd(-ringsize * 0.5, ringsize * 0.5)
			Local randomradius:Float = radius + random

			Local posx:Float = (randomradius - radius * 0.1) * Sin(ang)
			Local posy:Float = (randomradius - radius * 0.1) * Cos(ang)
			Local posz:Float = Rnd(-ringsize * 0.5, ringsize * 0.5)
			meshdata :+ "v " + posx + " " + posy + " " + posz + "~n"
		Next
		
		meshdata :+ "f"
		For Local i:Int = 0 Until 1800
			meshdata :+ " " + i
		Next

		Return meshdata
	EndMethod
EndType

Type tGlyph
	Field _indices:Int[]
	Field _bufferStartLocation:Int

	Method Create:tGlyph(indices:Int[])
		_indices = indices
		Return Self
	EndMethod	
EndType

Type tFont
	Field _glyphs:tGlyph[36]
	
	Field _vertices:Float[] =..
				 [ -0.4, -0.8, 0.0,..
		           -0.4, -0.3, 0.0,..
		           -0.4,  0.0, 0.0,..
	               -0.4,  0.3, 0.0,..
		           -0.4,  0.8, 0.0,..
		             0.0, -0.8, 0.0,..
		             0.0, -0.3, 0.0,..
		             0.0,  0.0, 0.0,..
				     0.0,  0.3, 0.0,..
		             0.0,  0.8, 0.0,..
		            0.4, -0.8, 0.0,..
		            0.4, -0.3, 0.0,..
                    0.4,  0.0, 0.0,..
		            0.4,  0.3, 0.0,..
		            0.4,  0.8, 0.0 ]

	Method New()
		Rem vertices
			 /    /    /
			4----9----14
			|    |    |
			|/   |/   |/
			3----8----13
			|    |    |
			|/   |/   |/
		    2----7----12
		    |    |    |  
		    |/   |/   |/
		    1----6----11
		    |    |    |
		    |/   |/   |/
		    0----5----10		
		EndRem
		 ' LINELIST

		' 0 to 10
		_glyphs[0] = New tGlyph.Create([0, 4, 4, 14, 14, 10, 10, 0])          ' 0
		_glyphs[1] = New tGlyph.Create([5, 9])                                ' 1
		_glyphs[2] = New tGlyph.Create([4, 14, 14, 12, 12, 2, 2, 0, 0, 10])   ' 2
		_glyphs[3] = New tGlyph.Create([4, 14, 14, 10, 10, 0, 12, 2])         ' 3
		_glyphs[4] = New tGlyph.Create([4, 1, 1, 11, 10, 14])                 ' 4
		_glyphs[5] = New tGlyph.Create([14, 4, 4, 2, 2, 12, 12, 10, 10, 0])   ' 5
		_glyphs[6] = New tGlyph.Create([4, 0, 0, 10, 10, 12, 12, 2])          ' 6
		_glyphs[7] = New tGlyph.Create([4, 14, 14, 10])                       ' 7
		_glyphs[8] = New tGlyph.Create([0, 4, 4, 14, 14, 10, 10, 0, 2, 12])   ' 8
		_glyphs[9] = New tGlyph.Create([10, 14, 14, 4, 4, 2, 2, 12])          ' 9

		' A to Z
		_glyphs[10] = New tGlyph.Create([0, 1, 1, 9, 9, 11, 11, 10, 1, 11])       ' A
		_glyphs[11] = New tGlyph.Create([0, 4, 4, 9, 9, 13, 13, 7, 7, 11, 11, 5, 5, 0, 2, 7])  ' B
		_glyphs[12] = New tGlyph.Create([10, 0, 0, 4, 4, 14])                     ' C
		_glyphs[13] = New tGlyph.Create([0, 4, 4, 9, 9, 13, 13, 11, 11, 5, 5, 0]) ' D
		_glyphs[14] = New tGlyph.Create([10, 0, 0, 4, 4, 14, 2, 7])               ' E
		_glyphs[15] = New tGlyph.Create([0, 4, 4, 14, 2, 7])                      ' F
		_glyphs[16] = New tGlyph.Create([14, 4, 4, 0, 0, 10, 10, 12, 12, 7])  ' G
		_glyphs[17] = New tGlyph.Create([0, 4, 10, 14, 2, 12])                    ' H
		_glyphs[18] = New tGlyph.Create([4, 14, 0, 10, 5, 9])                     ' I
		_glyphs[19] = New tGlyph.Create([4, 14, 14, 10, 10, 5, 5, 1])             ' J
		_glyphs[20] = New tGlyph.Create([0, 4, 2, 14, 2, 10])                     ' K
		_glyphs[21] = New tGlyph.Create([4, 0, 0, 10])                            ' L
		_glyphs[22] = New tGlyph.Create([0, 4, 4,  8, 8, 14, 14, 10])             ' M
		_glyphs[23] = New tGlyph.Create([0, 4, 4, 10, 10, 14])                    ' N
		_glyphs[24] = New tGlyph.Create([0, 4, 4, 14, 14, 10, 10, 0])             ' O
		_glyphs[25] = New tGlyph.Create([0, 4, 4, 14, 14, 12, 12, 2])             ' P
		_glyphs[26] = New tGlyph.Create([0, 4, 4, 14, 14, 11, 11, 5, 5, 0, 6, 10]) ' Q
		_glyphs[27] = New tGlyph.Create([0, 4, 4, 14, 14, 12, 12, 2, 2, 10])      ' R
		_glyphs[28] = New tGlyph.Create([14, 4, 4, 2, 2, 12, 12, 10, 10, 0])      ' S
		_glyphs[29] = New tGlyph.Create([5, 9, 4, 14])                            ' T
		_glyphs[30] = New tGlyph.Create([4, 0, 0, 10, 10, 14])                    ' U
		_glyphs[31] = New tGlyph.Create([4, 5, 5, 14])                            ' V
		_glyphs[32] = New tGlyph.Create([4, 0, 0, 6, 6, 10, 10, 14])              ' W
		_glyphs[33] = New tGlyph.Create([4, 10, 0, 14])                           ' X
		_glyphs[34] = New tGlyph.Create([4, 8, 8, 14, 8, 5])                      ' Y
		_glyphs[35] = New tGlyph.Create([4, 14, 14, 0, 0, 10])                    ' Z
	EndMethod
	
	Method asciiToData:Int(inAsc:Int)
		If inAsc >= 48 And inAsc <= 57 Return inAsc - 48        ' 0 to 9
		If inAsc >= 65 And inAsc <= 90 Return inAsc - 65 + 10   ' A to Z
		If inAsc >= 97 And inAsc <= 127 Return inAsc - 97 + 10
	EndMethod
	
	Method createSentence:tmesh(sentence:String)
		Local mesh:tmesh = New tmesh
		mesh._topology = D3D11_PRIMITIVE_TOPOLOGY_LINELIST

		Local x:Float, y:Float
		For Local i:Int = 0 Until sentence.length
			If sentence[i] <= 32
				x :+ 1
				
				If sentence[i] = 10 
					y :- 2 ' minus to go down in the 3d world
					x = 0
				EndIf
				
				Continue
			EndIf
				
			Local glyphIndex:Int = asciiToData(sentence[i])
			Local glyph:tglyph = _glyphs[glyphIndex]
			
			For Local index:Int = EachIn glyph._indices
				If index = -1 Continue
				' use i as an offset to push each letter to the right
				Local vertex:Float[] = [ _vertices[index * 3 + 0] + x + 0.5, _vertices[index * 3 + 1] + y + 0.5, _vertices[index * 3 + 2] ]
				mesh._vertices :+ vertex
			Next
			
			x :+ 1
		Next

		mesh._indices = New Int[mesh._vertices.length / 3]
		For Local index:Int = 0 Until mesh._indices.length
			mesh._indices[index] = index
		Next

		Return mesh
	EndMethod
EndType	

Type math
	Function identitym4(inout:Float[])
		MemClear(inout,64)
		inout[0] = 1.0; inout[5] = 1.0; inout[10] = 1.0; inout[15] = 1.0
	EndFunction
	
	Function multiplym4m4(ina:Float[], inb:Float[], inout:Float[])
		For Local i:Int = 0 Until 4
			For Local j:Int = 0 Until 4
				inout[i * 4 + j] = 0.0
				For Local k:Int = 0 Until 4
					inout[i * 4 + j] :+ ina[i * 4 + k] * inb[k * 4 + j]
				Next
			Next
		Next
	EndFunction
	
	Function multiplyv4m4(ina:Float[], inb:Float[], inout:Float[])
		For Local i:Int = 0 Until 4
			For Local j:Int = 0 Until 4
				inout[i] :+ ina[i] * inb[i * 4 + j]
			Next
		Next
	EndFunction
	
	Function rotationxm4(angle:Float, inout:Float[])
		inout[0] = 1.0;  inout[1] = 0.0;         inout[2] = 0.0;         inout[3] = 0.0
		inout[4] = 0.0;  inout[5] = Cos(angle);  inout[6] = Sin(angle);  inout[7] = 0.0
		inout[8] = 0.0;  inout[9] = -Sin(angle); inout[10] = Cos(angle); inout[11] = 0.0
		inout[12] = 0.0; inout[13] = 0.0;        inout[14] = 0.0;        inout[15] = 1.0
	EndFunction
	
	Function rotationym4(angle:Float, inout:Float[])
		inout[0] = Cos(angle); inout[1] = 0.0;  inout[2] = -Sin(angle); inout[3] = 0.0
		inout[4] = 0.0;        inout[5] = 1.0;  inout[6] = 0.0;         inout[7] = 0.0
		inout[8] = Sin(angle); inout[9] = 0.0; 	inout[10] = Cos(angle); inout[11] = 0.0
		inout[12] = 0.0;       inout[13] = 0.0; inout[14] = 0.0;        inout[15] = 1.0
	EndFunction

	Function rotationzm4(angle:Float, inout:Float[])
		inout[0] = Cos(angle);  inout[1] = Sin(angle); inout[2] = 0.0;  inout[3] = 0.0
		inout[4] = -Sin(angle); inout[5] = Cos(angle); inout[6] = 0.0;  inout[7] = 0.0
		inout[8] = 0.0;         inout[9] = 0.0;        inout[10] = 1.0; inout[11] = 0.0
		inout[12] = 0.0;        inout[13] = 0.0;       inout[14] = 0.0; inout[15] = 1.0
	EndFunction

	Function rotationxyzm4(x:Float, y:Float, z:Float, inout:Float[])
		inout[0] = Cos(y) * Cos(z) + Sin(y) * Sin(x) * Sin(z)
		inout[1] = -Cos(y) * Sin(z) + Sin(y) * Sin(x) * Cos(z)
		inout[2] = Sin(y) * Cos(x)
		inout[3] = 0.0
		inout[4] = Cos(x) * Sin(z)
		inout[5] = Cos(x) * Cos(z)
		inout[6] = -Sin(x)
		inout[7] = 0.0
		inout[8] = -Sin(y) * Cos(z) + Cos(y) * Sin(x) * Sin(z)
		inout[9] = Sin(y) * Sin(z) + Cos(y) * Sin(x) * Cos(z)
		inout[10] = Cos(y) * Cos(x)
		inout[11] = 0.0
		inout[12] = 0.0; inout[13] = 0.0; inout[14] = 0.0; inout[15] = 1.0
	EndFunction
	
	Method rotationaxism4(x:Float, y:Float, z:Float, ang:Float, inout:Float[])
		inout[0] = Cos(ang) + x * x * (1.0 - Cos(ang))
		inout[1] = x * y * (1.0 - Cos(ang) - z * Sin(ang))
		inout[2] = x * z * (1 - Cos(ang) + y * Sin(ang))
		inout[3] = 0.0
		inout[4] = y * x * (1 - Cos(ang)) + z * Sin(ang)
		inout[5] = Cos(ang) + y * y * (1 - Cos(ang))
		inout[6] = y * z * (1 - Cos(ang)) - x * Sin(ang)
		inout[7] = 0.0
		inout[8] = z * x * (1 - Cos(ang)) - y * Sin(ang)
		inout[9] = z * y * (1 - Cos(ang)) + x * Sin(ang)
		inout[10]= Cos(ang) + z * z * (1 - Cos(ang))
		inout[11]= 0.0
		inout[12] = 0.0; inout[13] = 0.0; inout[14] = 0.0; inout[15] = 1.0
	EndMethod
	
	Function quaternionTom4(x:Float, y:Float, z:Float, w:Float, inout:Float[])
		inout[0] = 1.0 - 2 * (Y * Y) - 2.0 * (Z  * Z)
		inout[1] = 2.0 * X * Y + 2.0 * W * Z
		inout[2] = 2.0 * X * Z - 2.0 * W * Y
		inout[3] = 0.0
		inout[4] = 2.0 * Y * X - 2.0 * W * Z
		inout[5] = 1.0 - 2 * (X * X) - 2 * (Z * Z)
		inout[6] = 2.0 * Y * Z + 2.0 * W * X
		inout[7] = 0.0
		inout[8] = 2.0 * Z * X + 2.0 * W * Y
		inout[9] = 2.0 * Z * Y - 2.0 * W * X
		inout[10] = 1.0 - 2 * (X * X) - 2 * (Y * Y)
		inout[11] = 0.0; 
		inout[12] = 0.0; inout[13] = 0.0; inout[14] = 0.0; inout[15] = 1.0
	EndFunction
	
	Function lerp:Float(a:Float, b:Float, t:Float)
		Return a + (b - a) * t
	EndFunction
EndType

Type tWindow
	Field _className:String
	Field _hWnd:Int
	
	Method New()
		_className = "warpClass"
	EndMethod
	
	Method Create:TWindow(Width:Int, Height:Int, X:Int = 0, Y:Int = 0)
		Local wc:WNDCLASSW = New WNDCLASSW
		wc.lpfnWndProc = WndProc
		wc.hInstance = GetModuleHandleW( Null )
		wc.lpfnWndProc = WndProc
		wc.hCursor = LoadCursorW( Null,Short Ptr IDC_ARROW )
		wc.lpszClassName = _className.ToWString()
		RegisterClassW(wc)
		MemFree wc.lpszClassName

		'centre window on screen
		Local rect:Int[4]
		Local wStyle:Int = WS_VISIBLE | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX

		Local desktoprect:Int[4]
		GetWindowRect(GetDesktopWindow() , desktoprect)

		If X <> 0 Or Y <> 0
			rect[0]=X
			rect[1]=Y
			rect[2]=X + Width
			rect[3]=Y + Height
			AdjustWindowRect rect,wstyle,0
		Else
			rect[0]=desktopRect[2]/2-width/2
			rect[1]=desktopRect[3]/2-height/2
			rect[2]=rect[0]+width
			rect[3]=rect[1]+height
			AdjustWindowRect rect,wstyle,0
		EndIf
		
		_hWnd = CreateWindowExW( 0,_className,AppTitle,wstyle,rect[0],rect[1],rect[2]-rect[0],rect[3]-rect[1],0,0,GetModuleHandleW(Null),Null )
		If Not _hWnd Throw "Cannot create window"
		
		EnablePolledInput()
		
		Return Self
	EndMethod
	
	Method getWindowHandle:Byte Ptr()
		Return Byte Ptr _hWnd
	EndMethod

	Function WndProc:Int(hWnd:Int, msg:Int, wParam:Int, lParam:Int)"Win32"
		bbSystemEmitOSEvent(hWnd, msg, wParam, lParam, Null)
		
		Select msg
		Case WM_CLOSE
			Return 0
		EndSelect
		
		Return DefWindowProcW(hWnd, msg, wParam, lParam)
	EndFunction
EndType

Type tGpuD3D11
	Field _device:ID3D11Device
	Field _context:ID3D11DeviceContext
	Field _swapchain:IDXGISwapchain
	
	Field _rasterState:ID3D11RasterizerState
	Field _depthStencilState:ID3D11DepthStencilState

	Field _backbufferView:ID3D11RendertargetView
	Field _depthstencilView:ID3D11DepthstencilView
	
	Method Create:TGpuD3D11(Width:Int, Height:Int, WindowHandle:Byte Ptr)
		createDeviceAndSwapchain(Width, Height, WindowHandle)
		createDepthtarget(Width, Height)
		createBackbuffer()
		createRasterizerState()
		createDepthStencilState()
		
		setDefaults(Width, Height)
		Return Self
	EndMethod
	
	Method createDeviceAndSwapchain(Width:Int, Height, WindowHandle:Byte Ptr)
		Local featureLevel:Int
		
		Local desc:DXGI_SWAP_CHAIN_DESC = New DXGI_SWAP_CHAIN_DESC
		desc.BufferCount = 2
		desc.BufferDesc_Width = width
		desc.BufferDesc_Height = height
		desc.BufferDesc_Format = DXGI_FORMAT_R8G8B8A8_UNORM
		desc.BufferDesc_RefreshRate_Numerator = 0
		desc.BufferDesc_RefreshRate_Denominator = 1
		desc.BufferDesc_Scaling = 0
		desc.BufferDesc_ScanlineOrdering = 0
		desc.Windowed = True			
		desc.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT
		desc.OutputWindow = Int WindowHandle
		desc.SwapEffect = DXGI_SWAP_EFFECT_DISCARD
		desc.Flags = DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH
		desc.SampleDesc_Count = 1
		desc.SampleDesc_Quality = 0

		D3D11CreateDeviceAndSwapchain(Null, D3D_DRIVER_TYPE_HARDWARE, Null, 0, Null, 0, D3D11_SDK_VERSION, desc, _swapchain, _device, Varptr featureLevel, _context )

		If Not _device Throw " could not create d3d11 device"
		If Not _context Throw " could not create d3d11 immediate context"
		If Not _swapchain Throw " could not create d3d11 swap chain"
	EndMethod
	
	Method createBackbuffer()
		Local swapchainTexture:ID3D11Texture2D
		_swapchain.getBuffer(0, IID_ID3D11TEXTURE2D, swapchainTexture)

		_device.createRenderTargetView(swapchainTexture, Null, _backbufferView)
		swapchainTexture.release_()
		
		If Not _backbufferView Throw " cannot create render target view"	
	EndMethod
	
	Method CreateDepthTarget:Int(Width:Int, Height:Int)
		Local textureDesc:D3D11_TEXTURE2D_DESC = New D3D11_TEXTURE2D_DESC
		textureDesc.Width = Width
		textureDesc.Height = Height
		textureDesc.MipLevels = 1
		textureDesc.ArraySize = 1
		textureDesc.Format = DXGI_FORMAT_R32_TYPELESS
		textureDesc.SampleDesc_Count = 1
		textureDesc.SampleDesc_Quality = 0
		textureDesc.Usage = D3D11_USAGE_DEFAULT
		textureDesc.BindFlags = D3D11_BIND_DEPTH_STENCIL ' | D3D11_BIND_SHADER_RESOURCE
		textureDesc.CPUAccessFlags = 0
		textureDesc.MiscFlags = 0
		
		Local depthstenciltexture:ID3D11Texture2D
		_device.createTexture2D(textureDesc, Null, depthStencilTexture)
		If Not depthStencilTexture Throw " could not create depth stencil texture"

		Local viewdesc:D3D11_DEPTH_STENCIL_VIEW_DESC = New D3D11_DEPTH_STENCIL_VIEW_DESC
		viewdesc.Format = DXGI_FORMAT_D32_FLOAT
		viewdesc.ViewDimension = D3D11_DSV_DIMENSION_TEXTURE2D
		
		_device.createDepthStencilView(depthStencilTexture, viewdesc, _depthStencilView)
		depthstencilTexture.release_
		
		If Not _depthStencilView Throw " could not create depth stencil view"
	EndMethod
	
	Method createRasterizerState()
		Local state:D3D11_RASTERIZER_DESC = New D3D11_RASTERIZER_DESC
		state.FillMode = D3D11_FILL_WIREFRAME
		state.CullMode = D3D11_CULL_BACK
		state.MultisampleEnable = True
		state.AntialiasedLineEnable = True
		state.DepthBias = -500
		
		_device.CreateRasterizerState(state, _rasterstate)
		If Not _rasterstate Throw " could not create rasterizer state"
	EndMethod
	
	Method createDepthStencilState()
		Local desc:D3D11_DEPTH_STENCIL_DESC = New D3D11_DEPTH_STENCIL_DESC
		desc.DepthEnable = False
		
		_device.CreateDepthStencilState(desc, _depthStencilState)
	EndMethod
	
	Method setDefaults(Width:Int, Height:Int)
		_context.RSSetViewports(1, [0.0, 0.0, Float(Width), Float(Height), 0.0, 1.0])
		_context.OMSetRenderTargets(1, Varptr _backbufferView, _depthstencilView)
	EndMethod

	Method ClearBackbuffer(colour:Float[])
		_context.clearDepthStencilView(_depthstencilView, D3D11_CLEAR_DEPTH, 1.0, 0)
		_context.clearRendertargetView(_backbufferView, colour)
	EndMethod
	
	Method Present(VWait:Int)
		_swapchain.present(VWait, 0)
	EndMethod
	
	Method SetWireframeOn()
		_context.RSSetState(_rasterState)
	EndMethod
	
	Method SetWireframeOff()
		_context.RSSetState(Null)
	EndMethod
	
	Method TurnOnDepthTesting()
		_context.OMSetDepthStencilState(Null, 0)
	EndMethod
	
	Method TurnOffDepthTesting()
		_context.OMSetDepthStencilState(_depthstencilstate, 0)
	EndMethod
	
	Method setBackbuffer()
		_context.OMSetRenderTargets(1, Varptr _backbufferView, _depthstencilView)
	EndMethod
EndType

Type tGame
	Field _gamestate:Int

	Field _window:TWindow
	Field _pipeline:TGpuD3D11
	
	Field _vsConstants:ID3D11Buffer
	Field _psConstants:ID3D11Buffer

	Field _inputLayout:ID3D11InputLayout
	Field _vertexShader:ID3D11VertexShader
	Field _pixelShader:ID3D11PixelShader
	
	Field _quadVertexBuffer:ID3D11Buffer
	Field _quadConstantsBuffeR:ID3D11Buffer
	Field _quadRendertargetView:ID3D11RendertargetView
	Field _quadShaderView:ID3D11ShaderResourceView
	Field _quadInputLayout:ID3D11InputLayout
	Field _quadVertexShader:ID3D11VertexShader
	Field _quadPixelShader:ID3D11PixelShader
	Field _quadSampler:ID3D11SamplerState
	Field _quadParamConstants:ID3D11Buffer
	
	Field _view:Float[16]
	Field _proj:Float[16]
	
	Field _root:tobject
	Field _scene:tobject

	Field _meshdata:tMeshData

	Field _ship:tobject			' on screen ship
	Field _shipbasic:tobject
	Field _shipbasicwire:tobject
	Field _shipbasicsolid:tobject
	
	Field _shipupgraded:tobject
	Field _shipupgradedwire:tobject
	Field _shipupgradedsolid:tobject
	
	Field _bombActive:Float
	Field _bombTime:Float
	Field _bombCentreX:Float
	Field _bombCentreY:Float

	Field _powerUp:tobject 		' on screen power up
	Field _shippowerup:tobject
	Field _galacticBomb:tObject
	
	Field _alien:tobject 	' on screen alien
	Field _alienbig:tobject
	Field _alienLittle:tObject
	Field _alienShipController:tAlienShipControlAnimator
	Field _alienbullet:tobject

	Field _rockstore:TList
	Field _particleStore:TList
	
	Field _font:tFont
	Field _copyright:tobject
	Field _pressToStart:tobject
	Field _title:tobject
	
	Field _planetcore:tobject
	Field _planet:tobject
	Field _beltInner:tobject
	Field _beltOuter:tobject
	
	Field _score:Int
	Field _scoreobject:tobject
	
	Field _highscore:Int = 10000
	Field _highscoreobject:tobject
	
	Field _waveComplete:tobject
	Field _getReady:tobject
	
	Field _rocksToDestroy:Int
	Field _currentWave:Int
		
	Field _bulletstore:TList
	
	Field _sampleUpgrade:TSound
	Field _sampleShot:TSound
	Field _sampleLife:TSound
	Field _sampleRocks:TSound[3]
	Field _sampleAlien:TSound[2]	
	Field _sampleThump:TSound[2]
	Field _sampleAlienShot:TSound
	Field _channelAlien:TChannel
	
	Field _sampleIntro:TSound
	Field _channelIntro:TChannel
	
	Const COLLISION_ID_SHIP:Int = 1
	Const COLLISION_ID_BULLET:Int = 2
	Const COLLISION_ID_ROCK:Int = 3
	Const COLLISION_ID_ALIEN:Int = 4
	Const COLLISION_ID_ALIEN_BULLET:Int = 5
	Const COLLISION_ID_POWERUP:Int = 6

	Method init(Width:Int, Height:Int)
		_meshdata = New tMeshData
		_particleStore = New TList
		_bulletstore = New TList
		_rockstore = New TList
		
		' setup root
		_root = New tobject
		_root.setname("root")
		_root.setExtra(Self)
		
		Local collisionManager:tCollisionManager = New tCollisionManager
		collisionManager.addCollidableIds(COLLISION_ID_SHIP, COLLISION_ID_ROCK, New tShipToRockHandler)
		collisionManager.addCollidableIds(COLLISION_ID_BULLET, COLLISION_ID_ROCK, New tBulletToRockHandler)
		collisionManager.addCollidableIds(COLLISION_ID_BULLET, COLLISION_ID_ALIEN, New tShipBulletToAlienHandler)
		collisionManager.addCollidableIds(COLLISION_ID_ALIEN_BULLET, COLLISION_ID_SHIP, New tAlienBulletToShipHandler)
		collisionManager.addCollidableIds(COLLISION_ID_ALIEN_BULLET, COLLISION_ID_ROCK, New tAlienBulletToRockHandler)
		collisionManager.addCollidableIds(COLLISION_ID_ALIEN, COLLISION_ID_ROCK, New tAlienShipToRockHandler)
		collisionManager.addCollidableIds(COLLISION_ID_SHIP, COLLISION_ID_POWERUP, New tShipPowerUpHandler)

		_root.addAnimator(collisionManager)
		
		_alienShipController = New tAlienShipControlAnimator
		_root.addAnimator(_alienShipController)
		
		' setup the game scene object
		_scene = New tobject
		_scene.setparent(_root)
		_scene.setname("scene")

		_window = New TWindow.Create(Width, Height)
		_pipeline = New TGpuD3D11.Create(Width, Height, _window.getWindowHandle())
	
		_view = [1.0, 0.0, 0.0, 0.0,..
		         0.0, 1.0, 0.0, 0.0,..
				 0.0, 0.0, 1.0, 60.0,..
				 0.0, 0.0, 0.0, 1.0]
		
		createShaderResources()
		createQuadResources(Width, Height)
		createGameObjects()
	EndMethod
	
	Method createQuadResources(Width:Int, Height:Int)
		' create vertex buffer
		Local quadVertices:Float[]
		quadVertices :+ [-1.0, -1.0, 0.0, 0.0, 1.0]
		quadVertices :+ [-1.0,  1.0, 0.0, 0.0, 0.0]
		quadVertices :+ [ 1.0,  1.0, 0.0, 1.0, 0.0]
		quadVertices :+ [-1.0, -1.0, 0.0, 0.0, 1.0]
		quadVertices :+ [ 1.0,  1.0, 0.0, 1.0, 0.0]
		quadVertices :+ [ 1.0, -1.0, 0.0, 1.0, 1.0]
		
		Local desc:D3D11_BUFFER_DESC = New D3D11_BUFFER_DESC
		desc.ByteWidth = SizeOf(quadVertices)
		desc.Usage = D3D11_USAGE_DEFAULT
		desc.BindFlags = D3D11_BIND_VERTEX_BUFFER
		
		Local data:D3D11_SUBRESOURCE_DATA = New D3D11_SUBRESOURCE_DATA
		data.pSysMem = quadVertices
		
		_pipeline._device.createBuffer(desc, data, _quadVertexBuffer)
		If Not _quadVertexBuffer Throw " cannot create quad vertex buffer"
		
		' bomb parameters
		desc.ByteWidth = 16
		desc.Usage = D3D11_USAGE_DYNAMIC
		desc.BindFlags = D3D11_BIND_CONSTANT_BUFFER
		desc.CPUAccessFlags = D3D11_CPU_ACCESS_WRITE
		
		_pipeline._device.createBuffer(desc, Null, _quadConstantsBuffer)
		If Not _quadConstantsBuffer Throw " cannot create quad constants buffer"

		' create render target texture
		Local textureDesc:D3D11_TEXTURE2D_DESC = New D3D11_TEXTURE2D_DESC
		textureDesc.Width = Width
		textureDesc.Height = Height
		textureDesc.MipLevels = 1
		textureDesc.ArraySize = 1
		textureDesc.Format = DXGI_FORMAT_R8G8B8A8_UNORM
		textureDesc.SampleDesc_Count = 1
		textureDesc.SampleDesc_Quality = 0
		textureDesc.Usage = D3D11_USAGE_DEFAULT
		textureDesc.BindFlags = D3D11_BIND_RENDER_TARGET | D3D11_BIND_SHADER_RESOURCE
		textureDesc.CPUAccessFlags = 0
		textureDesc.MiscFlags = 0
		
		Local texture:ID3D11Texture2D
		_pipeline._device.createTexture2D(textureDesc, Null, texture)
		If Not texture Throw " could not create render target texture"

		' create render target from texture
		Local targetDesc:D3D11_RENDER_TARGET_VIEW_DESC = New D3D11_RENDER_TARGET_VIEW_DESC
		targetDesc.format = DXGI_FORMAT_R8G8B8A8_UNORM
		targetDesc.viewDimension = 4 ' D3D11_RTV_DIMENSION_TEXTURE2D
		
		_pipeline._device.createRenderTargetView(texture, targetDesc, _quadRendertargetView)
		If Not _quadRendertargetView Throw " could not create render target view"

		' create shader resource from texture
		Local shaderDesc:D3D11_SHADER_RESOURCE_VIEW_DESC = New D3D11_SHADER_RESOURCE_VIEW_DESC
		shaderDesc.format = DXGI_FORMAT_R8G8B8A8_UNORM
		shaderDesc.viewDimension = 4 ' D3D11_RTV_DIMENSION_TEXTURE2D
		shaderDesc.Texture_MipLevels = 1
		
		_pipeline._device.createShaderResourceView(texture, shaderDesc, _quadShaderView)
		If Not _quadShaderView Throw " could not create shader resource view for render target"
	
		' texture sampler
		Local samplerDesc:D3D11_SAMPLER_DESC = New D3D11_SAMPLER_DESC
		samplerDesc.Filter = D3D11_FILTER_MIN_MAG_MIP_LINEAR
		samplerDesc.AddressU = D3D11_TEXTURE_ADDRESS_CLAMP
		samplerDesc.AddressV = D3D11_TEXTURE_ADDRESS_CLAMP
		samplerDesc.AddressW = D3D11_TEXTURE_ADDRESS_CLAMP
		samplerDesc.ComparisonFunc = D3D11_COMPARISON_ALWAYS
		
		_pipeline._device.createSamplerState(samplerDesc, _quadSampler)
		If Not _quadSampler Throw " cannot create quad texture sampler"
		
		' shaders
		Local vertexshaderByteCode:ID3DBlob = createShaderSourceByteCode(shaderSource(), "VSMainQuad", "vs_5_0")
		Local pixelshaderByteCode:ID3DBlob = createShaderSourceByteCode(shaderSource(), "PSMainQuad", "ps_5_0")

		' input layout
		Local layout:Int[]
		layout :+ [0, 0, DXGI_FORMAT_R32G32B32_FLOAT, 0, D3D11_APPEND_ALIGNED_ELEMENT, D3D11_INPUT_PER_VERTEX_DATA, 0]
		layout :+ [0, 0, DXGI_FORMAT_R32G32_FLOAT, 0, D3D11_APPEND_ALIGNED_ELEMENT, D3D11_INPUT_PER_VERTEX_DATA, 0 ]

		Local pPosition:Byte Ptr = "POSITION".ToCString()
		Local pUV:Byte Ptr = "TEXCOORD".ToCString()
		layout[0] = Int(pPosition)
		layout[7] = Int(pUV)

		Local shaderByteCodeLength:Int = vertexshaderByteCode.getBufferSize()
		Local pShaderByteCode:Byte Ptr = vertexshaderByteCode.getBufferPointer()
		
		_pipeline._device.createInputLayout(layout, layout.length / 7, pShaderByteCode, shaderByteCodeLength, _quadInputLayout)
		If Not _quadInputLayout Throw " cannot create quad input layout"

		' vertex shader
		_pipeline._device.createVertexShader(pShaderByteCode, shaderByteCodeLength, Null, _quadVertexShader)
		If Not _quadVertexShader Throw " cannot create quad vertex shader"
	
		' compile and create pixel shader
		shaderByteCodeLength = pixelshaderByteCode.getBufferSize()
		pShaderByteCode = pixelshaderByteCode.getBufferPointer()

		_pipeline._device.createPixelShader(pShaderByteCode, shaderByteCodeLength, Null, _quadPixelShader)
		If Not _quadPixelShader Throw " cannot create quad pixel shader"

		' clean up
		texture.release_()
		MemFree(pPosition)
		MemFree(pUV)		
		vertexshaderByteCode.Release_()
		pixelshaderByteCode.Release_()	

	EndMethod
	
	Method createGameObjects()
		' sounds
		_sampleIntro = LoadSound("sounds/intro.wav", SOUND_LOOP)
		
		_sampleUpgrade = LoadSound("sounds/upgrade.wav")
		_sampleShot = LoadSound("sounds/fire.wav")
		_sampleLife = LoadSound("sounds/life.wav")
		_sampleRocks[0] = LoadSound("sounds/explode3.wav")
		_sampleRocks[1] = LoadSound("sounds/explode2.wav")
		_sampleRocks[2] = LoadSound("sounds/explode1.wav")
		_sampleAlien[0] = LoadSound("sounds/lsaucer.wav", SOUND_LOOP)
		_sampleAlien[1] = LoadSound("sounds/ssaucer.wav", SOUND_LOOP)
		_sampleAlienShot = LoadSound("sounds/sfire.wav")
		
		' font
		_font = New tFont
		
		' score
		_scoreobject = New tobjectscore.Create(_pipeline._device, Null, _scene, RENDERFLAG_WIREFRAME)
		_scoreobject.moveTo(-21, 13, -5)
		tobjectscore(_scoreobject).setscorepointer(Varptr _score)

		_highscoreobject = New tobjectscore.Create(_pipeline._device, Null, _scene, RENDERFLAG_WIREFRAME)
		_highscoreobject.moveTo(0, 13, -5)
		tobjectscore(_highscoreobject).setscorepointer(Varptr _highscore)
		
		' title
		Local msg:String = "StarRoids"
		_title = New tobject
		_title.setparent(_scene)
		_title.moveTo(0, 7, -5)
		_title.setname("title")

		Local titleMesh:tmesh = _font.createsentence(msg)
		titlemesh.scale(2, 2, 2)

		Local titleObject:tobject = New tObject.Create(_pipeline._device, titleMesh, _title, RENDERFLAG_WIREFRAME)
		titleObject.moveto( -Float(msg.length), -0.5, 0)
		titleobject.setname("titleobject")
		
		' get ready
		msg = "get ready"
		Local getreadymesh:tmesh = _font.createsentence(msg)
		_getready = New tobject.Create(_pipeline._device, getreadymesh, Null, RENDERFLAG_WIREFRAME)
		_getready.moveTo(-Float(msg.length) / 2.0, 0.0, -30.0)
		
		 'wave complete
		msg = "wave complete"
		Local wavecompletemesh:tmesh = _font.createsentence(msg)
		_wavecomplete = New tobject.Create(_pipeline._device, wavecompletemesh, Null, RENDERFLAG_WIREFRAME)
		_wavecomplete.moveTo(-6.5, 0.0, -60.0)

		' planet core
		_planetcore:tobject = New tobject
		_planetcore.setparent(_scene)
		_planetcore.moveTo(0.0, 10.0, 160.0)
		_planetcore.setname("planet core")

		' planet
		Local planetdata:String = New tasteroid.Create()
		Local planetmesh:tmesh = parsemeshdata(planetdata, 16)
		_planet = New tobject.Create(_pipeline._device, planetmesh, _planetcore, RENDERFLAG_SOLID | RENDERFLAG_WIREFRAME)
		_planet.setname("planet")

		Local planetrotation:tRotationAnimator = New tRotationAnimator
		planetrotation.init(0.0, -0.1, 0.0)
		_planet.addAnimator(planetrotation)
		_planet.setcolourWireframe(0.8, 0.2, 0.1, 1.0)

		' asteroid belt	
		Local belt:tobject = New tobject
		belt.setparent(_planetcore)
		belt.rotateTo(118.0, 0.0, 0.0)
		belt.setname("belt")
		
		Local titlebeltOutermeshdata:String = New tasteroidbelt.CreateOuter()
		Local titlebeltOutermesh:tmesh = parsemeshdata(titlebeltOutermeshdata, 3.5)
		_beltOuter = New tobject.Create(_pipeline._device, titlebeltOutermesh, belt, RENDERFLAG_WIREFRAME)
		_beltOuter.setColourWireframe(0.5, 0.5, 0.5, 1.0)
		_beltOuter.setname("title asteroid belt outer")

		Local rotationOuter:tRotationAnimator = New tRotationAnimator
		rotationOuter.init(0.0, 0.0, 0.1)
		_beltOuter.addAnimator(rotationOuter)
		
		Local titlebeltInnermeshData:String = New tasteroidbelt.CreateInner()
		Local titlebeltInnermesh:tmesh = parsemeshdata(titlebeltInnermeshdata, 3.5)
		_beltInner = New tobject.Create(_pipeline._device, titlebeltInnermesh, belt, RENDERFLAG_WIREFRAME)
		_beltInner.setColourWireframe(0.6, 0.6, 0.7, 1.0)
		_beltInner.setname("title asteroid belt inner")

		Local rotationInner:tRotationAnimator = New tRotationAnimator
		rotationInner.init(0.0, 0.0, 0.11)
		_beltInner.addAnimator(rotationInner)

		' press to start
		msg = "press space to play"
		_pressToStart = New tobject
		_pressToStart.setparent(_scene)
		_pressToStart.moveTo(0, -4, 0)
		_pressToStart.addAnimator(New tIntroAnimator)
		_pressToStart.setname("pressstart")
	
		Local pressToStartMesh:tmesh = _font.createsentence(msg)
		Local pressToStartObject:tobject = New tObject.Create(_pipeline._device, pressToStartMesh, _pressToStart, RENDERFLAG_WIREFRAME)
		pressToStartObject.moveto( -msg.length / 2.0, -0.5, 0)
		pressToStartObject.setName("presstostartobject")

		' create copyright for atari
		_copyright = New tobject
		_copyright.setparent(_scene)
		_copyright.moveTo(0, -14, -5)
		_copyright.setname("copyright")
		
		msg = "original game idea by atari inc 1979"
		Local textmesh:tmesh = _font.createSentence(msg)
		textmesh.scale(0.5, 0.5, 0.5)

		Local text:tobject = New tObject.Create(_pipeline._device, textmesh, _copyright, RENDERFLAG_WIREFRAME)
		text.moveto( -Float(msg.length) / 4, -0.25, 0.0)
		text.setname("copyrighttext")
	
		Local textRoller:tRollAnimator = New tRollAnimator
		textRoller.init(1, 5000, 3000, MilliSecs())
		_copyright.addAnimator(textRoller)

		' create ship
		_shipbasic = New tobject
		_shipbasic.setCollisionId(COLLISION_ID_SHIP)
		_shipbasic.setCollisionRadius(0.7)
		_shipbasic.setName("shipbasic")
		
		Local shipAnimator:tShipAnimator = New tShipAnimator
		_shipbasic.addAnimator(shipAnimator)
		
		Local shipmeshwire:tmesh = parsemeshdata(_meshdata.shipWireframe(), 1.0)
		_shipbasicwire = New tobject.Create(_pipeline._device, shipmeshwire, _shipbasic, RENDERFLAG_WIREFRAME)
		_shipbasicwire.setName("shipbasicwire")
		_shipbasicwire.moveTo(0.0, 0.0, -0.15)

		Local shipmeshsolid:tmesh = parsemeshdata(_meshdata.shipSolid(), 1.0)
		_shipbasicsolid = New tobject.Create(_pipeline._device, shipmeshsolid, _shipbasic, RENDERFLAG_SOLID)
		_shipbasicsolid.setName("shipbasicsolid")

		' upgraded ship
		_shipupgraded = New tobject
		_shipupgraded.setName("upgradedship")
		_shipupgraded.addAnimator(shipAnimator)
		_shipupgraded.setCollisionId(COLLISION_ID_SHIP)
		_shipupgraded.setCollisionRadius(0.8)

		Local shipupgradedwire:tmesh = parsemeshdata(_meshdata.shipUpgradedWireframe(), 0.2)
		_shipupgradedwire = New tobject.Create(_pipeline._device, shipupgradedwire, _shipupgraded, RENDERFLAG_WIREFRAME)
		_shipupgradedwire.setName("shipupgradedwire")
		_shipupgradedwire.moveTo(0.0, 0.0, -0.15)
		
		Local shipupgradedsolid:tmesh = parsemeshdata(_meshdata.shipUpgradedSolid(), 0.2)
		_shipupgradedsolid = New tobject.Create(_pipeline._device, shipupgradedsolid, _shipupgraded, RENDERFLAG_SOLID)
		_shipupgradedsolid.setName("shipupgradedsolid")
		
		' powerupship
		Local powerupshipmeshsolid:tmesh = parsemeshdata(_meshdata.powerupshipsolid(), 0.4)
		Local powerupshipmeshwireframe:tmesh = parsemeshdata(_meshdata.powerupshipWireframe(), 0.41)
		_shipPowerUp = New tobject.Create(_pipeline._device, powerupshipmeshsolid, Null, RENDERFLAG_SOLID)
		Local powerupshipwireframe:tobject = New tobject.Create(_pipeline._device, powerupshipmeshwireframe, _shipPowerUp, RENDERFLAG_WIREFRAME)
		_shipPowerUp.setCollisionId(COLLISION_ID_POWERUP)
		_shipPowerUp.setCollisionRadius(1.0)
		_shipPowerUp.setname("powerup-ship")
		
		Local anim:trotationanimator = New trotationanimator
		anim.init(0.0, -1.0, 0.0)
		_shippowerup.addanimator(anim)
		
		' galactic bomb
		Local bombmesh:tmesh = parsemeshdata(_meshdata.galacticbomb(), 1.0)
		'_galacticBomb = New tobject.Create(_pipeline._device, bombmesh, _scene, RENDERFLAG_WIREFRAME)
		'_galacticBomb.setCollisionId(COLLISION_ID_POWERUP)
		'_galacticBomb.setCollisionRadius(1.0)
		'_galacticBomb.setName("bomb")

		' alien big ship
		Local alienmesh:tmesh = parseMeshData(_meshdata.alienbigwireframe(), 1.0)
		alienmesh.scale(1.0, 2.0, 1.0)	
		_alienbig = New tobject.Create(_pipeline._device, alienmesh, Null, RENDERFLAG_WIREFRAME)
		_alienbig.setCollisionId(COLLISION_ID_ALIEN)
		_alienbig.setCollisionRadius(1.0)
		_alienbig.setname("alienBig")

		' alien little ship
		alienmesh.scale(0.5, 1.0, 0.5)
		_alienLittle = New tObject.Create(_pipeline._device, alienmesh, Null, RENDERFLAG_WIREFRAME)
		_alienLittle.setCollisionId(COLLISION_ID_ALIEN)
		_alienLittle.setCollisionRadius(0.6)
		_alienLittle.setname("alienLittle")

		
		' alien bullet
		_alienBullet = New tObject.Create(_pipeline._device, parseMeshData(_meshdata.alienbulletWireframe(), 0.2), Null, RENDERFLAG_WIREFRAME)
		_alienBullet.setCollisionRadius(0.2)
		_alienBullet.setCollisionId(COLLISION_ID_ALIEN_BULLET)
		
		' create bullets
		Local bulletMesh:tMesh = parsemeshdata(_meshdata.bulletWireframe(), 1.0)
		For Local i:Int = 0 Until 36
			Local bullet:tobject = New tobject.Create(_pipeline._device, bulletMesh, Null, RENDERFLAG_WIREFRAME)
			bullet.setCollisionId(COLLISION_ID_BULLET)
			bullet.setCollisionRadius(0.1)
			_bulletstore.addlast(bullet)
		Next
		
		' create some explosion particles
		Local particledata:String = New tasteroid.Create()
		Local particleMesh:tmesh = parsemeshdata(particledata, Rnd(0.01, 0.05))

		For Local i:Int = 0 Until 256
			Local particle:tobject = New tobject.Create(_pipeline._device, particleMesh, Null, RENDERFLAG_WIREFRAME)
			_particleStore.addLast(particle)
		Next
		
		' create some rocks
		Local rockdata:String = New tasteroid.Create()
		
		' create 16 big rocks
		For Local i:Int = 0 Until 16
			Local rockmesh:tmesh = parsemeshdata(rockdata, 1.0)
			Local rock:tobject = New tobjectrock.Create(_pipeline._device, rockmesh, Null, RENDERFLAG_SOLID | RENDERFLAG_WIREFRAME)
			rock.setCollisionId(COLLISION_ID_ROCK)
			rock.setCollisionRadius(1.8)
			rock.setColourSolid(0.12, 0.12, 0.12, 1.0)
			
			tobjectrock(rock).setSize(3)			
			_rockstore.addLast(rock)
		Next
		
		' 32 middle size
		For Local i:Int = 0 Until 32
			Local rockmesh:tmesh = parsemeshdata(rockdata, 0.6)
			Local rock:tobject = New tobjectrock.Create(_pipeline._device, rockmesh, Null, RENDERFLAG_SOLID | RENDERFLAG_WIREFRAME)
			rock.setCollisionId(COLLISION_ID_ROCK)
			rock.setCollisionRadius(1.8 * 0.6)
			rock.setColourSolid(0.12, 0.12, 0.12, 1.0)
			
			tobjectrock(rock).setSize(2)
			_rockstore.addLast(rock)
		Next

		'  64 small - should be waaay more than enough
		For Local i:Int = 0 Until 64
			Local rockmesh:tmesh = parsemeshdata(rockdata, 0.3)
			Local rock:tobject = New tobjectrock.Create(_pipeline._device, rockmesh, Null, RENDERFLAG_SOLID | RENDERFLAG_WIREFRAME)
			rock.setCollisionId(COLLISION_ID_ROCK)
			rock.setCollisionRadius(1.8 * 0.3)
			rock.setColourSolid(0.12, 0.12, 0.12, 1.0)
			
			tobjectrock(rock).setSize(1)
			_rockstore.addLast(rock)
		Next
	EndMethod
	
	Method getRock:tobject(rocksize:Int)
		For Local obj:tobject = EachIn _rockstore
			Local rock:tobjectrock = tobjectrock(obj)
			If rock And rock._size = rocksize
				_rockstore.remove(rock)
				Return rock
			EndIf
		Next
	EndMethod

	Method parsemeshdata:tmesh(data:String, scale:Float)
		Local lines:String[] = data.split("~n")
		Local mesh:tmesh = New tmesh

		For Local line:String = EachIn lines
			Local comp:String[] = line.split(" ")

			Select comp[0]
			Case "pointlist" mesh._topology = D3D11_PRIMITIVE_TOPOLOGY_POINTLIST
			Case "linelist" mesh._topology = D3D11_PRIMITIVE_TOPOLOGY_LINELIST
			Case "linestrip" mesh._topology = D3D11_PRIMITIVE_TOPOLOGY_LINESTRIP
			Case "trianglelist" mesh._topology = D3D11_PRIMITIVE_TOPOLOGY_TRIANGLELIST
			Case "trianglestrip" mesh._topology = D3D11_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP

			Case "v"
				mesh._vertices :+ [ comp[1].toFloat(), comp[2].toFloat(), comp[3].toFloat() ]

			Case "f"
				For Local i:Int = 1 Until comp.length
					mesh._indices :+ [ comp[i].toInt() ]
				Next
			EndSelect
		Next
		
		mesh.scale(scale, scale, scale)
		Return mesh
	EndMethod
	
	Method set2DProjection(Width:Float, Height:Float)
		_proj = [ 2.0/Width,0.0,0.0,-1-(1.0/Width)+(1.0/Width),..
				  0.0,-2.0/Height,0.0,1+(1.0/Height)-(1.0/Height),..
				  0.0,0.0,1.0,0.0,..
				  0.0,0.0,0.0,1.0]
	EndMethod
	
	Method set3DProjection(FovY:Float, Aspect:Float, Near:Float, Far:Float)
		Local ys:Float = 1.0 / Tan(fovY * 0.5)
		Local xs:Float = ys / aspect
		Local range:Float = far - near
		
		_proj = [  xs, 0.0, 0.0, 0.0,..
				  0.0, ys,  0.0, 0.0,..
				  0.0, 0.0, far/range, -near * far / range,..
				  0.0, 0.0, 1.0, 0.0]
	EndMethod
	
	Method createShaderResources()
		' vertex shader constants - per frame
		Local desc:D3D11_BUFFER_DESC = New D3D11_BUFFER_DESC
		desc.ByteWidth = 128
		desc.Usage = D3D11_USAGE_DYNAMIC
		desc.BindFlags = D3D11_BIND_CONSTANT_BUFFER
		desc.cpuAccessFlags = D3D11_CPU_ACCESS_WRITE

		_pipeline._device.createBuffer(desc, Null, _vsConstants)
		If Not _vsConstants Throw " cannot create buffer for vertex shader per frame constants"
		
		' pixel shader constants - per frame
		desc.ByteWidth = 16
		_pipeline._device.createBuffer(desc, Null, _psConstants)
		If Not _vsConstants Throw " cannot create buffer for pixel shader per frame constants"
		
		' shaders
		Local vertexshaderByteCode:ID3DBlob = createShaderSourceByteCode(shaderSource(), "VSMain", "vs_5_0")
		Local pixelshaderByteCode:ID3DBlob = createShaderSourceByteCode(shaderSource(), "PSMain", "ps_5_0")

		' input layout
		Local layout:Int[] = [0, 0, DXGI_FORMAT_R32G32B32_FLOAT, 0, D3D11_APPEND_ALIGNED_ELEMENT, D3D11_INPUT_PER_VERTEX_DATA, 0]
		Local pPosition:Byte Ptr = "POSITION".ToCString()
		layout[0] = Int(pPosition)

		Local shaderByteCodeLength:Int = vertexshaderByteCode.getBufferSize()
		Local pShaderByteCode:Byte Ptr = vertexshaderByteCode.getBufferPointer()
		
		_pipeline._device.createInputLayout(layout, layout.length / 7, pShaderByteCode, shaderByteCodeLength, _inputLayout)
		If Not _inputLayout Throw " cannot create input layout"

		' vertex shader
		_pipeline._device.createVertexShader(pShaderByteCode, shaderByteCodeLength, Null, _vertexShader)
		If Not _vertexShader Throw " cannot create vertex shader"
	
		' compile and create pixel shader
		shaderByteCodeLength = pixelshaderByteCode.getBufferSize()
		pShaderByteCode = pixelshaderByteCode.getBufferPointer()

		_pipeline._device.createPixelShader(pShaderByteCode, shaderByteCodeLength, Null, _pixelShader)
		If Not _pixelShader Throw " cannot create pixel shader"

		' clean up
		MemFree(pPosition)		
		vertexshaderByteCode.Release_()
		pixelshaderByteCode.Release_()	
	EndMethod

	Method createShaderSourceByteCode:ID3DBlob(source:String, func:String, profile:String)
		Local pShader:Byte Ptr = source.ToCString()
		Local pFunc:Byte Ptr = func.ToCString()
		Local pProfile:Byte Ptr = profile.ToCString()

		Local byteCode:ID3DBlob
		Local error:ID3DBlob

		Local flag:Int = D3DCOMPILE_OPTIMIZATION_LEVEL3
		?debug
		flag = D3DCOMPILE_DEBUG
		?
		D3DCompile(pShader, source.length, Null, Null, Null, pFunc, pProfile, flag, 0, byteCode, error)
		
		If error
			Throw String.FromCString(error.getBufferPointer())
			error.release_()
		EndIf
		
		MemFree(pProfile)
		MemFree(pShader)
		MemFree(pFunc)
		
		Return byteCode
	EndMethod
	
	Method shaderSource:String()
		Local source:String
		source :+ "cbuffer perFrame{~n"
		source :+ "   float4x4 view;~n"
		source :+ "   float4x4 proj;~n"
		source :+ "};~n"
		
		source :+ "cbuffer perObject{~n"
		source :+ "   float4x4 model;~n"
		source :+ "};~n"

		source :+ "struct VSINPUT{~n"
		source :+ "   float4 pos : POSITION;~n"
		source :+ "};~n" ' 10
		
		source :+ "struct PSINPUT{~n"
		source :+ "   float4 pos : SV_POSITION;~n"
		source :+ "};~n"
		
		source :+ "PSINPUT VSMain(VSINPUT vsIn){~n"
		source :+ "   PSINPUT vsOut;~n"

		source :+ "   float4x4 viewproj = mul(view, proj);~n"
		source :+ "   float4 posWorld = mul(float4(vsIn.pos.xyz, 1.0f), model);~n"
		source :+ "   vsOut.pos = mul(posWorld, viewproj);~n"

		source :+ "   return vsOut;~n"
		source :+ "}~n" ' 20
		
		source :+ "cbuffer perFrame{~n"
		source :+ "    float4 colour;~n"
		source :+ "}~n"
		source :+ "float4 PSMain(PSINPUT psIn) : SV_Target{~n"
		source :+ "    return colour;~n"
		source :+ "};~n"

		source :+ "Texture2D quadTexture;~n"
		source :+ "SamplerState quadSampler;~n"
		
		source :+ "struct VSINPUTQUAD{~n"
		source :+ "   float3 pos : POSITION;~n" ' 30
		source :+ "   float2 uv : TEXCOORD0;~n"
		source :+ "};~n"
		
		source :+ "struct PSINPUTQUAD{~n"
		source :+ "   float4 pos : SV_POSITION;~n"
		source :+ "   float2 uv : TEXCOORD0;~n"
		source :+ "};~n"

		source :+ "PSINPUTQUAD VSMainQuad(VSINPUTQUAD vsIn){~n"
		source :+ "   PSINPUTQUAD vsOut;~n"

		source :+ "   vsOut.pos = float4(vsIn.pos, 1.0);~n"
		source :+ "   vsOut.uv = vsIn.uv;~n" ' 40
		source :+ "   return vsOut;~n"
		source :+ "}~n"
		
		source :+ "cbuffer params{~n"
		source :+ "    float freq;~n"
		source :+ "    float time;~n"
		source :+ "    float2 centre;~n"
		source :+ "}~n"

		source :+ "float4 PSMainQuad(PSINPUTQUAD psIn) : SV_Target{~n"
		source :+ "    float2 uv = psIn.pos.xy - centre;~n"
		source :+ "    float color = 1-smoothstep(-((time/8) * (time/8)), 20, abs(length(uv/4) - time + sin(atan2(uv.y, uv.x))));~n"

		source :+ "    if(freq != 0){~n"
		source :+ "        uv = psIn.uv * cos(color);~n"
		source :+ "    }~n"
		source :+ "    else{~n"
		source :+ "        uv = psIn.uv;~n"
		source :+ "    }~n"
		
		source :+ "    return float4(quadTexture.Sample(quadSampler, uv) + (sin(color) * freq));~n;~n"
		source :+ "};~n"

		Return source
	EndMethod
	
	Method run()
		set3DProjection(30.0, 1200.0 / 700.0, 0.1, 1000.0)

		While Not AppTerminate()
			Select _gamestate
			Case -1 Exit
			Case 0 updateintro()
			Case 1 updategame()
			EndSelect
		Wend
	EndMethod
	
	Method beginGameLevel()
		_rocksToDestroy = 0

		Local velMin:Float = 0.02 + ((_currentWave + 1) / 200.0)
		Local velMax:Float = 0.05 + ((_currentWave + 1) / 200.0)

		Local wave:Int = _currentWave
		If wave > 5 wave = 5

		_alienShipController.init(MilliSecs(), True)
		
		' top edge
		For Local i:Int = 0 Until (3 + wave) / 3
			_rocksToDestroy :+ 1
			Local rock:tobject = getRock(3)
			If rock
				rock.setparent(_scene)
				rock.moveTo(Rnd(-29, 29), 18 + Rnd(-1, 1), 0)
				rock.update(MilliSecs())

				' big rock will move slower
				Local rockanim:tRockAnimator = New tRockAnimator
				rockanim.init(Rnd(-velMax, velMax), Rnd(-velMin, -velMax), 0.0,  Rnd(-1, 1), Rnd(-1, 1), Rnd(-1, 1))
				rock.addAnimator(rockanim)
			EndIf
		Next

		' bottom edge
		For Local i:Int = 0 Until (3 + wave) / 3
			_rocksToDestroy :+ 1
			Local rock:tobject = getRock(3)
			If rock
				rock.setparent(_scene)
				rock.moveTo(Rnd(-29, 29), -18 + Rnd(-1, 1), 0)
				rock.update(MilliSecs())

				' big rock will move slower
				Local rockanim:tRockAnimator = New tRockAnimator
				rockanim.init(Rnd(-velMax, velMax), Rnd(velMin, velMax), 0.0,  Rnd(-1, 1), Rnd(-1, 1), Rnd(-1, 1))
				rock.addAnimator(rockanim)
			EndIf
		Next

		' left edge
		For Local i:Int = 0 Until (3 + wave) / 4
			_rocksToDestroy :+ 1
			Local rock:tobject = getRock(3)
			If rock
				rock.setparent(_scene)
				rock.moveTo(-29.5 + Rnd(-1, 1), Rnd(-18, 18), 0)
				rock.update(MilliSecs())

				' big rock will move slower
				Local rockanim:tRockAnimator = New tRockAnimator
				rockanim.init(Rnd(velMin, velMax), Rnd(-velMax, velMax), 0.0,  Rnd(-1, 1), Rnd(-1, 1), Rnd(-1, 1))
				rock.addAnimator(rockanim)
			EndIf
		Next

		' righttedge
		For Local i:Int = 0 Until (3 + wave) / 4
			_rocksToDestroy :+ 1
			Local rock:tobject = getRock(3)
			If rock
				rock.setparent(_scene)
				rock.moveTo(29 + Rnd(-1, 1), Rnd(-18, 18), 0)
				rock.update(MilliSecs())

				' big rock will move slower
				Local rockanim:tRockAnimator = New tRockAnimator
				rockanim.init(Rnd(-velMin, -velMax), Rnd(-velMax, velMax), 0.0,  Rnd(-1, 1), Rnd(-1, 1), Rnd(-1, 1))
				rock.addAnimator(rockanim)
			EndIf
		Next	
	EndMethod

	Method updateintro()
		updategamelogic(MilliSecs())	
		rendergame()
	EndMethod

	Method updategame()
		updategamelogic(MilliSecs())
		rendergame()
	EndMethod

	Method updategamelogic(timeMs:Int)
		If KeyDown(KEY_ESCAPE) _gamestate = -1

		_root.update(timeMs)
	EndMethod

	Method rendergame()
			prepareToRenderToQuad()
			
			' start frame
			_pipeline._context.VSSetConstantBuffers(0, 1, Varptr _vsConstants)
			_pipeline._context.VSSetShader(_vertexShader, Null, 0)
			_pipeline._context.PSSetShader(_pixelShader, Null, 0)

			' per frame
			Local map:D3D11_MAPPED_SUBRESOURCE = New D3D11_MAPPED_SUBRESOURCE
			_pipeline._context.Map(_vsConstants, 0, D3D11_MAP_WRITE_DISCARD, 0, map)
			MemCopy(map.pData, _view, 64)
			MemCopy(map.pData + 64, _proj, 64)
			_pipeline._context.Unmap(_vsConstants, 0)

			renderscene()

			' need to quad shader, set the texture for the quad, render quad to backbuffer
			renderQuadToBackBuffer()

			_pipeline.Present(True)
	EndMethod
	
	Method prepareToRenderToQuad()
		Local colour:Float[0.0, 0.0, 0.0, 1.0]
		
		_pipeline._context.OMSetRenderTargets(1, Varptr _quadRendertargetView, _pipeline._depthstencilView)
		_pipeline._context.clearDepthStencilView(_pipeline._depthstencilView, D3D11_CLEAR_DEPTH, 1.0, 0)
		_pipeline._context.clearRendertargetView(_quadRendertargetView, colour)

		_pipeline._context.IASetInputLayout(_inputLayout)
		_pipeline._context.VSSetShader(_vertexShader, Null, 0)
		_pipeline._context.PSSetShader(_pixelShader, Null, 0)
		_pipeline._context.PSSetConstantBuffers(0, 1, Varptr _psConstants)
	EndMethod
	
	Method renderQuadToBackBuffer()
		Local map:D3D11_MAPPED_SUBRESOURCE = New D3D11_MAPPED_SUBRESOURCE
		_pipeline._context.map(_quadConstantsBuffer, 0, D3D11_MAP_WRITE_DISCARD, 0, map)
		MemCopy(map.pData, Varptr _bombActive, 4)
		MemCopy(map.pData + 4, Varptr _bombTime, 4)
		MemCopy(map.pData + 8, Varptr _bombCentreX, 4)
		MemCopy(map.pData + 12, Varptr _bombCentreY, 4)
		_pipeline._context.Unmap(_quadConstantsBuffer, 0)
		
		Local stride:Int = 20
		Local offset:Int = 0

		_pipeline.setBackbuffer()
		_pipeline.setWireframeOff()
		
		_pipeline._context.IASetInputLayout(_quadInputLayout)
		_pipeline._context.IASetVertexBuffers(0, 1, Varptr _quadVertexBuffer, Varptr stride, Varptr offset)
		_pipeline._context.IASetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_TRIANGLELIST)
		_pipeline._context.VSSetShader(_quadVertexShader, Null, 0)
		_pipeline._context.PSSetConstantBuffers(0, 1, Varptr _quadConstantsBuffer)	
		_pipeline._context.PSSetShader(_quadPixelShader, Null, 0)
		_pipeline._context.PSSetShaderResources(0, 1, Varptr _quadShaderView)
		_pipeline._context.PSSetSamplers(0, 1, Varptr _quadSampler)
		
		_pipeline._context.draw(6, 0)
	EndMethod
	
	Method renderscene()
		_pipeline.setWireframeOff()
		_scene.renderSolid(_pipeline._context)

		_pipeline.setWireframeOn()
		_scene.renderWireframe(_pipeline._context)
	EndMethod
	
	' a central method to break the rock, the ship bullet, alien bullet can break rocks
	Method destroyRock(rock:tobjectrock, timeMs:Int)
		' remove the rock
		rock._animators.clear()
		rock.setparent(Null)
		_rockstore.addlast(rock)
		_rocksToDestroy :- 1
		
		' create an explosion
		Local posx:Float = rock._posx
		Local posy:Float = rock._posy
		Local posz:Float = rock._posz

		Local epicentre:tobject = New tobject
		epicentre.setparent(_scene)

		PlaySound(_sampleRocks[rock._size - 1])

		For Local i:Int = 0 Until 16
			Local particleanim:tParticleAnimator = New tParticleAnimator
			particleanim.init(Rnd(-0.5,0.5), Rnd(-0.5,0.5), Rnd(-0.5, 0.5), 0.0, 0.0, 0.0, timeMs, 200 + rock._size * 100)
			
			Local particle:tobject = tobject(_particlestore.removefirst())
			If particle
				particle.setParent(epicentre)
				particle.moveTo(posx, posy, posz)
				particle.addAnimator(particleanim)
			EndIf
		Next
			
		' split the rock into 2
		Local size:Int = rock._size - 1
		If size <> 0
			Local newRockCount:Int = 2 ' Rand(2, 3)
			
			For Local i:Int = 0 Until newRockCount
				Local newrock:tobjectrock = tobjectrock(getRock(size))
				If newrock
					_rockstodestroy :+ 1
					Local vel:Float = (1.0 / size / 1.5) * ((_currentWave + 1) * 0.05)
					Local velx:Float = Rnd(-vel, vel)
					Local vely:Float = Rnd(-vel, vel)
					
					' make sure that the rock is always moving
					If velx > -0.01 And velx <= 0.0 velx = -0.01
					If vely > -0.01 And velx <= 0.0 vely = -0.01
					If velx < 0.01 And velx >= 0.0 velx = 0.01
					If vely < 0.01 And vely >= 0.0 vely = 0.01
					
					' but don't let it move too fast
					velx = Min(Max(-0.35,velx), 0.35)
					vely = Min(Max(-0.35,vely), 0.35)
					
					newrock.moveTo(posx, posy, posz)
					newrock.setparent(_scene)
						
					' smaller rocks will move faster
					Local rockanim:tRockAnimator = New tRockAnimator
					rockanim.init(velx, vely, 0.0,  Rnd(-1, 1), Rnd(-1, 1), Rnd(-1, 1))
					newrock.addAnimator(rockanim)
				EndIf
			Next
		EndIf
	EndMethod

	Method shutdown()
	EndMethod
EndType

Type tmesh
	Field _topology:Int
	Field _vertices:Float[]
	Field _indices:Int[]
	
	Method scale(x:Float, y:Float, z:Float)
		For Local i:Int = 0 Until _vertices.length Step 3
			_vertices[i + 0] = _vertices[i + 0] * x
			_vertices[i + 1] = _vertices[i + 1] * y
			_vertices[i + 2] = _vertices[i + 2] * z
		Next
	EndMethod
EndType

Type tobject
	Field _parent:tobject
	Field _extra:Object

	Field _children:TList
	Field _name:String

	Field _animators:TList
	
	Field _rotx:Float, _roty:Float, _rotz:Float
	Field _posx:Float, _posy:Float, _posz:Float
	Field _local:Float[16]
	Field _world:Float[16]

	Field _vertexbuffer:ID3D11Buffer
	Field _indexbuffer:ID3D11Buffer
	Field _worldbuffer:ID3D11Buffer
	
	Field _indexCount:Int
	Field _topology:Int
	
	Field _collisionId:Int
	Field _collisionRadius:Float
	
	Field _colourWireframe:Float[4]
	Field _colourSolid:Float[4]

	Field _renderFlag:Int

	Method New()
		_animators = New TList
		_children = New TList
		math.identitym4(_local)
		math.identitym4(_world)
		
		_colourWireframe = [1.0, 1.0, 1.0, 1.0]
		_colourSolid = [0.0, 0.0, 0.0, 1.0]
	EndMethod
	
	Method Create:tobject(device:ID3D11Device, mesh:tmesh, parent:tobject, renderFlag:Int)
		' vertex buffer
		Local desc:D3D11_BUFFER_DESC = New D3D11_BUFFER_DESC
		desc.ByteWidth = SizeOf(mesh._vertices)
		desc.Usage = D3D11_USAGE_DEFAULT
		desc.BindFlags = D3D11_BIND_VERTEX_BUFFER

		Local data:D3D11_SUBRESOURCE_DATA = New D3D11_SUBRESOURCE_DATA
		data.pSysMem = mesh._vertices
		
		device.createBuffer(desc, data, _vertexBuffer)
		If Not _vertexBuffer Throw " cannot create vertex buffer"

		' index buffer
		desc.ByteWidth = SizeOf(mesh._indices)
		desc.BindFlags = D3D11_BIND_INDEX_BUFFER
		
		data.pSysMem = mesh._indices
		
		device.createBuffer(desc, data, _indexBuffer)
		If Not _indexBuffer Throw " cannot create index buffer"

		' world buffer
		desc.ByteWidth = 64
		desc.Usage = D3D11_USAGE_DYNAMIC
		desc.BindFlags = D3D11_BIND_CONSTANT_BUFFER
		desc.cpuAccessFlags = D3D11_CPU_ACCESS_WRITE

		device.createBuffer(desc, Null, _worldBuffer)
		If Not _worldBuffer Throw " cannot create world constant buffer"

		_indexCount = mesh._indices.length
		_topology = mesh._topology
		_renderflag = renderflag
		
		setParent(parent)		
		Return Self
	EndMethod
	
	Method getRoot:tobject()
		Local parent:tobject = _parent
		If parent
			While parent._parent
				parent = parent._parent
			Wend
			Return parent
		EndIf
		Return Self
	EndMethod

	Method _removeChild(child:tobject)
		If _children.contains(child) _children.remove(child)
	EndMethod
	
	Method _addchild(child:tobject)
		If Not _children.contains(child) _children.addlast(child)
	EndMethod

	Method setName(name:String)
		_name = name
	EndMethod

	Method setParent(parent:tobject)
		If _parent _parent._removeChild(Self)
		If parent parent._addchild(Self)
		
		_parent = parent
	EndMethod
	
	Method setExtra(extra:Object)
		_extra = extra
	EndMethod
	
	Method setCollisionId(Id:Int)
		_collisionId = Id
	EndMethod
	
	Method setCollisionRadius(radius:Float)
		_collisionRadius = radius
	EndMethod
	
	Method setColourWireframe(r:Float, g:Float, b:Float, a:Float)
		_colourWireframe[0] = r; _colourWireframe[1] = g; _colourWireframe[2] = b; _colourWireframe[3] = a
	EndMethod
	
	Method setColourSolid(r:Float, g:Float, b:Float, a:Float)
		_colourSolid[0] = r; _colourSolid[1] = g; _colourSolid[2] = b; _colourSolid[3] = a
	EndMethod

	
	Method moveTo(x:Float, y:Float, z:Float)
		_posx = x; _posy = y; _posz = z
	EndMethod
	
	Method rotateTo(x:Float, y:Float, z:Float)
		_rotx = x; _roty = y; _rotz = z
	EndMethod

	Method update(timeMs:Int)
		For Local anim:tanimator = EachIn _animators
			anim.animate(Self, timeMs)
		Next
		updatelocal()

		If _parent
			math.multiplym4m4(_parent._world, _local, _world)
		Else
			MemCopy(_world, _local, 64)
		EndIf
		
		For Local obj:tobject = EachIn _children
			obj.update(timeMs)
		Next
	EndMethod
	
	Method updatelocal()
		Local qXw:Float = Cos(_rotX * 0.5)
		Local qXx:Float = Sin(_rotX * 0.5)
		Local qYw:Float = Cos(_rotY * 0.5)
		Local qYy:Float = Sin(_rotY * 0.5)
		Local qZw:Float = Cos(_rotZ * 0.5)
		Local qZz:Float = Sin(_rotZ * 0.5)

		' qX * qY
		Local qW:Float = qXw * qYw
		Local qX:Float = qXx * qYw
		Local qY:Float = qXw * qYy
		Local qZ:Float = qXx * qYy
		
		' ( qX * qY ) * qZ
		Local W:Float =  qw * qZw - qz * qZz
		Local X:Float =  qx * qZw + qy * qZz
		Local Y:Float = -qx * qZz + qy * qZw
		Local Z:Float =  qw * qZz + qz * qZw

		math.quaternionTom4(x, y, z, w, _local)
		_local[3] = _posx
		_local[7] = _posy
		_local[11] = _posz		
	EndMethod
	
	Method renderSolid(context:ID3D11DeviceContext)
		If _renderflag & RENDERFLAG_SOLID
			Local root:tobject = getRoot()
			Local game:tgame = tgame(root._extra)
			
			Local map:D3D11_MAPPED_SUBRESOURCE = New D3D11_MAPPED_SUBRESOURCE
			context.Map(game._psConstants, 0, D3D11_MAP_WRITE_DISCARD, 0, map)
			MemCopy(map.pData, _colourSolid, 16)
			context.Unmap(game._psConstants, 0)

			render(context)
		EndIf

		For Local obj:tobject = EachIn _children
			obj.renderSolid(context)
		Next
	EndMethod

	Method renderWireframe(context:ID3D11DeviceContext)
		If _renderflag & RENDERFLAG_WIREFRAME
			Local root:tobject = getRoot()
			Local game:tgame = tgame(root._extra)
			
			Local map:D3D11_MAPPED_SUBRESOURCE = New D3D11_MAPPED_SUBRESOURCE
			context.Map(game._psConstants, 0, D3D11_MAP_WRITE_DISCARD, 0, map)
			MemCopy(map.pData, _colourWireframe, 16)
			context.Unmap(game._psConstants, 0)
			
			render(context)
		EndIf
		
		For Local obj:tobject = EachIn _children
			obj.renderWireframe(context)
		Next
	EndMethod
	
	Method render(context:ID3D11DeviceContext)
		If _worldbuffer
			Local map:D3D11_MAPPED_SUBRESOURCE = New D3D11_MAPPED_SUBRESOURCE
	
			context.Map(_worldbuffer, 0, D3D11_MAP_WRITE_DISCARD, 0, map)
			MemCopy(map.pData, _world, 64)
			context.Unmap(_worldbuffer, 0)
	
			Local strides:Int = 12
			Local offsets:Int = 0
			context.IASetVertexBuffers(0, 1, Varptr _vertexBuffer, Varptr strides, Varptr offsets)
			context.IASetIndexBuffer(_indexBuffer, DXGI_FORMAT_R32_UINT, 0)
			context.VSSetConstantBuffers(1, 1, Varptr _worldbuffer)
			context.IASetPrimitiveTopology(_topology)
			context.DrawIndexed(_indexCount, 0, 0)
		EndIf
	EndMethod
	
	Method addAnimator(animator:tAnimator)
		_animators.addlast(animator)
	EndMethod
	
	Method removeAnimator(animator:tAnimator)
		For Local anim:tanimator = EachIn _animators
			If animator = anim _animators.remove(animator)
		Next
	EndMethod
EndType

Type tobjectRock Extends tobject
	Field _size:Int ' range from 3 to 1 - 0 to destroy
	
	Method setSize(size:Int)
		_size = size
	EndMethod
EndType

Type tobjectScore Extends tobject
	Field _scorepointer:Int Ptr
	Field _chars:tobject[10]

	Method Create:tobjectscore(device:ID3D11Device, mesh:tmesh, parent:tobject, renderFlag:Int)
		setparent(parent)
		
		' current score
		Local root:tobject = getroot()
		Local game:tgame = tgame(root._extra)
		
		For Local i:Int = 0 Until 10
			Local mesh:tmesh = game._font.createsentence(Chr(i + 48))
			_chars[i] = New tobject.Create(game._pipeline._device, mesh, Self, RENDERFLAG_WIREFRAME)
		Next
		
		Return Self
	EndMethod
	
	Method setscorepointer(scorepointer:Int Ptr)
		_scorepointer = scorepointer
	EndMethod
	
	Method renderWireframe(context:ID3D11DeviceContext)
		Local score:String
		If(_scorepointer)
			score = _scorepointer[0]
		Else
			score = 0
		EndIf

		Local xpos:Float = -(score.length / 2.0)		
		For Local i:Int = 0 Until score.length
			If score[i] >= 48 And score[i] <= 57
				Local ch:Int = score[i] - 48
				_chars[ch].moveTo(xpos + i, 0.0, 0.0)
				
				_chars[ch].updatelocal()
				
				' each char parent is 'this' so use own world position
				math.multiplym4m4(_world, _chars[ch]._local, _chars[ch]._world)
				
				_chars[ch].renderWireframe(context)
			EndIf
		Next
	EndMethod
EndType

Type tanimator
	Method animate(obj:tobject, timeMs:Int) Abstract
EndType

Type tIntroAnimator Extends tAnimator
	Method animate(obj:tobject, timeMs:Int)
		Local root:tobject = obj.getroot()
		If Not root Return
		
		Local game:tGame = tGame(root._extra)
		If Not game._channelIntro game._channelIntro = PlaySound(game._sampleIntro)
		
		
		If KeyDown(KEY_SPACE)
			FlushKeys()
					
			game._gamestate = 1
			
			game._pressToStart.setParent(Null)
			game._title.setparent(Null)
			game._currentWave = 1

			game._ship = game._shipbasic
			game._powerup = Null
			game._alien = Null
			
			Local begin:tBeginLevelAnimator = New tBeginLevelAnimator
			begin.init(timeMs)
			game._scene.addAnimator(begin)
		EndIf
	EndMethod
EndType

Type tBeginLevelAnimator Extends tAnimator
	Field _initTimeMs:Int
	Field _state:Int
	
	Field _targetx:Float
	Field _targety:Float
	Field _targetz:Float
	
	Method init(initTimeMs:Int)
		_initTimeMs = initTimeMs
		_state = 0
		
		Local a:Int = Rand(0, 3)
		Select a
		Case 0
			_targetx = 34.0
			_targety = 22.0
			_targetz = 30.0
			
		Case 1
			_targetx = 14.0
			_targety = 28.0
			_targetz = 24.0

		Case 2
			_targetx = -14.0
			_targety = 28.0
			_targetz = 24.0

		Case 3
			_targetx = -34.0
			_targety = 22.0
			_targetz = 30.0
		EndSelect	
	EndMethod

	Method animate(obj:tobject, timeMs:Int)
		Local root:tobject = obj.getroot()
		Local game:tgame = tgame(root._extra)
		
		If _state = 0
			Local core:tobject = game._planetcore
			Local x:Float = core._posx
			Local y:Float = core._posy
			Local z:Float = core._posz
					
			Local distx:Float = _targetx - x
			Local disty:Float = _targety - y
			Local distz:Float = _targetz - z
			
			Local dx:Float = core._posx + distx * 0.05
			Local dy:Float = core._posy + disty * 0.05
			Local dz:Float = core._posz + distz * 0.05
			core.moveTo(dx, dy, dz)
			
			Local delta:Float = Sqr(distx * distx + disty * disty + distz * distz)
			If delta < 0.1
				game._ship.setparent(game._scene)	
				game._getready.setparent(game._scene)
				_initTimeMs = timeMs
				_state = 1
			EndIf
		
		Else If _state = 1
			If timeMs > _initTimeMs + 1000
				game._getready.setparent(Null)
				game._scene.removeAnimator(Self)
				game.beginGamelevel()
			EndIf
		EndIf
	EndMethod
EndType

Type tLeaveLevelAnimator Extends tAnimator
	Field _initTimeMs:Int
	Field _state:Int
	
	Method init(initTimeMs:Int)
		_initTimeMs = initTimeMs
		_state = 0
	EndMethod

	Method animate(obj:tobject, timeMs:Int)
		Local root:tobject = obj.getroot()
		Local game:tgame = tgame(root._extra)

		If game._alien
			game._alien.setParent(Null)
			game._alien._animators.clear()
			game._alien = Null
		EndIf
		game._alienShipController.init(timeMs, False)
		If game._channelAlien StopChannel(game._channelAlien)

		If game._powerUp
			game._powerUp._animators.clear()
			game._powerUp.setParent(Null)
			game._powerUp = Null
		EndIf

		If _state = 0
			If timeMs > _initTimeMs + 1500			
				Local core:tobject = game._planetcore
				Local x:Float = core._posx
				Local y:Float = core._posy
				Local z:Float = core._posz
				
				Local destx:Float = 0.0
				Local desty:Float = 10.0
				Local destz:Float = 160.0
				
				Local distx:Float = destx - x
				Local disty:Float = desty - y
				Local distz:Float = destz - z
				
				Local dx:Float = core._posx + distx * 0.05
				Local dy:Float = core._posy + disty * 0.05
				Local dz:Float = core._posz + distz * 0.05
				core.moveTo(dx, dy, dz)
				
				Local delta:Float = Sqr(distx * distx + disty * disty + distz * distz)
				
				If delta < 0.1
					core.moveTo(0.0, 10.0, 160.0)
	
					game._waveComplete.setparent(game._scene)
					_initTimeMs = timeMs
					_state = 1
				EndIf
			EndIf
		
		Else If _state = 1
			If timeMs > _initTimeMs + 1000
				game._scene.removeanimator(Self)

				Local anim:twavecompleteanimator = New twavecompleteanimator
				anim.init(timeMs)
				game._waveComplete.setparent(game._scene)
				game._scene.addAnimator(anim)
			EndIf
		EndIf
	EndMethod
EndType

Type tWaveCompleteAnimator Extends tAnimator
	Field _initTimeMs:Int

	Method init(initTimeMs:Int)
		_initTimeMs = initTimeMs
	EndMethod

	Method animate(obj:tobject, timeMs:Int)
		Local timeTakenMs:Int = timeMs - _initTimeMs
		
		Local root:tobject = obj.getroot()
		Local game:tgame = tgame(root._extra)
		Local wave:tobject = game._wavecomplete

		' wait then show 'wave complete'
		If timeTakenMs < 500
			Local tMs:Float = ((timeTakenMs - 500 ) / 1000.0) / 2.5
			Local posz:Float = Cos(tMs * 180 / Pi)
			wave.moveTo(wave._posx, wave._posy, wave._posz + posz)
		EndIf
		
		If timeTakenMs > 3000 And timeTakenMs < 3500
			Local tMs:Float = ((timeTakenMs -3000 ) / 1000.0) / 2.5
			Local posz:Float = Cos(tMs * 180 / Pi)
			wave.moveTo(wave._posx, wave._posy, wave._posz - posz)
		EndIf
		
		If timeTakenMs > 3500 wave.moveTo(wave._posx, wave._posy, -65.0)
		
		If timeTakenMs > 4500
			obj.removeanimator(Self)
			game._wavecomplete.setparent(Null)
			game._currentWave :+ 1
			
			Local begin:tBeginLevelAnimator = New tBeginLevelAnimator
			begin.init(timeMs)
			game._scene.addAnimator(begin)
		EndIf
	EndMethod
EndType

Type tRollAnimator Extends tanimator
	Field _lastTimeMs:Int
	Field _nextTimeMs:Int
	Field _timeToRollMs:Int
	Field _timeToWaitMs:Int
	Field _state:Int				' 0 is idle, 1 is rotating
	Field _axis:Int

	Method init(axis:Int, waitTimeMs:Int, timeToRollMs:Int, initTimeMs:Int)
		_axis = axis
		_timeToWaitMs = waitTimeMs
		_timeToRollMs = timeToRollMs
		
		_lastTimeMs = initTimeMs
		_nextTimeMs:Int = _lastTimeMs + _timeToRollMs
	EndMethod
	
	Method animate(obj:tobject, timeMs:Int)
		Local time:Int = timeMs - _lastTimeMs
		Select _state
		Case 0
			If timeMs >= _lastTimeMs + _timeToWaitMs
				_state = 1
				_nextTimeMs :+ _timeToRollMs
				_lastTimeMs = timeMs
			EndIf
		
		Case 1
			' standard lerp
			Local t:Float = (timeMs - _lastTimeMs) / Float(_timeToRollMs)
			Local ang:Float = math.lerp(0.0, 360.0, t)
			
			Select _axis
			Case 1 obj.rotateTo(ang, 0, 0)
			Case 2 obj.rotateTo(0, ang, 0)
			Case 3 obj.rotateTo(ang, ang, 0)
			Case 4 obj.rotateTo(0, 0, ang)
			Case 5 obj.rotateTo(ang, 0, ang)
			Case 6 obj.rotateTo( 0, ang, ang)
			Case 7 obj.rotateTo(ang, ang, ang)
			EndSelect
			
			If time  > _timeToRollMs
				obj.rotateTo(0, 0, 0)
				_lastTimeMs = timeMs
				_state = 0
			EndIf

		EndSelect
	EndMethod
EndType

Type tShipAnimator Extends tanimator
	Field _velx:Float
	Field _vely:Float
	Field _velz:Float
	
	Method animate(obj:tObject, timeMs:Int)
		Local root:tobject = obj.getroot()
		If Not root Return

		Local game:tgame = tgame(root._extra)
			
		Local st:Float = 5
		If KeyDown(KEY_LEFT) obj.rotateTo(obj._rotx, obj._roty, obj._rotz - st)
		If KeyDown(KEY_RIGHT) obj.rotateTo(obj._rotx, obj._roty, obj._rotz + st)
	
		If KeyHit(KEY_DOWN)
			Local bombAnim:tBombParameterAnimator = New tBombParameterAnimator
			game._scene.addAnimator(bombAnim)
		EndIf

		' adjust some thrust
		If KeyDown(KEY_UP)
			_velx :+ 0.01 * Sin(obj._rotz)
			_vely :+ 0.01 * Cos(obj._rotz)

			_velx = Max(-0.6, Min(_velx, 0.6))
			_vely = Max(-0.6, Min(_vely, 0.6))
			
			'PlaySound(game._sampleThrust)
		EndIf
		
		Local posx:Float = obj._posx
		Local posy:Float = obj._posy
		Local posz:Float = obj._posz
		posx :+ _velx; posy :+ _vely; posz :+ _velz
		
		If posy < -17.0 posy = 17.0
		If posy > 17 posy = -17.0
		If posx < -29.0 posx = 29.0
		If posx > 29.0 posx = -29.0
		obj.moveTo(posx, posy, posz)

		If KeyHit(KEY_SPACE)
			Local bullet:tobject = tobject(game._bulletstore.removefirst())
			If Not bullet Return
			
			PlaySound(game._sampleShot)

			Local velx:Float = Sin(obj._rotz)
			Local vely:Float = Cos(obj._rotz)
			Local animator:tBulletAnimator = New tBulletAnimator
			animator.init(velx, vely, 0.0, 500, timeMs)
		
			bullet.addAnimator(animator)
			bullet.setParent(game._scene)
			bullet.moveTo(obj._posx + velx, obj._posy + vely, 0.0)
				
			If game._ship = game._shipUpgraded
				' create another bullet
				bullet = tobject(game._bulletstore.removefirst())
				If Not bullet Return

				velx = Sin(obj._rotz - 10)
				vely = Cos(obj._rotz - 10)
			
				animator = New tBulletAnimator
				animator.init(velx, vely, 0.0, 500, timeMs)
				
				' move the bullet to the correct position
				velx :- Sin(obj._rotz + 25) * 2
				vely :- Cos(obj._rotz + 25) * 2

				bullet.addAnimator(animator)
				bullet.setParent(game._scene)
				bullet.moveTo(obj._posx + velx, obj._posy + vely, 0.0)

				' create another bullet
				bullet = tobject(game._bulletstore.removefirst())
				If Not bullet Return
				
				velx = Sin(obj._rotz + 10)
				vely = Cos(obj._rotz + 10)
				
				animator = New tBulletAnimator
				animator.init(velx, vely, 0.0, 500, timeMs)
				
				velx = Sin(obj._rotz) - Sin(obj._rotz - 25) * 2
				vely = Cos(obj._rotz) - Cos(obj._rotz - 25) * 2
				
				bullet.addAnimator(animator)
				bullet.setParent(game._scene)
				bullet.moveTo(obj._posx + velx, obj._posy + vely, 0.0)
			EndIf				
		EndIf	
	EndMethod
EndType

Type tvelocityAnimator Extends tAnimator
	Field _velx:Float
	Field _vely:Float
	Field _velz:Float
	
	Method init(velx:Float, vely:Float, velz:Float)
		_velx = velx
		_vely = vely
		_velz = velz
	EndMethod
	
	Method animate(obj:tObject, timeMs:Int)	
		obj._posx :+ _velx
		obj._posy :+ _vely
		obj._posz :+ _velz
	EndMethod
EndType

Type tbulletAnimator Extends tanimator
	Field _velx:Float
	Field _vely:Float
	Field _velz:Float
	Field _lifeTimeMs:Int
	Field _spawnTimeMs:Int

	Method init(velx:Float, vely:Float, velz:Float, lifeTimeMs:Int, spawnTimeMs:Int)
		_velx = velx
		_vely = vely
		_velz = velz
		_lifeTimeMs = lifeTimeMs
		_spawnTimeMs = spawnTimeMs
	EndMethod
	
	Method animate(obj:tobject, timeMs:Int)
		Local posx:Float = obj._posx
		Local posy:Float = obj._posy
		Local posz:Float = obj._posz
		posx :+ _velx; posy :+ _vely; posz :+ _velz
		
		If posy < -18.0 posy = 18.0
		If posy > 18 posy = -18.0
		If posx < -29.5 posx = 29.5
		If posx > 29.5 posx = -29.5
		obj.moveTo(posx, posy, posz)
			
		If timeMs > _spawnTimeMs + _lifeTimeMs
			Local root:tobject = obj.getroot()
			Local game:tgame = tgame(root._extra)
			
			obj._animators.clear()
			obj.setParent(Null)
			game._bulletstore.addlast(obj)
		EndIf
	EndMethod
EndType

Type tAlienBulletAnimator Extends tanimator
	Field _velx:Float
	Field _vely:Float
	Field _velz:Float
	Field _lifeTimeMs:Int
	Field _spawnTimeMs:Int

	Method init(velx:Float, vely:Float, velz:Float, lifeTimeMs:Int, spawnTimeMs:Int)
		_velx = velx
		_vely = vely
		_velz = velz
		_lifeTimeMs = lifeTimeMs
		_spawnTimeMs = spawnTimeMs
	EndMethod
	
	Method animate(obj:tobject, timeMs:Int)
		Local posx:Float = obj._posx
		Local posy:Float = obj._posy
		Local posz:Float = obj._posz
		posx :+ _velx; posy :+ _vely; posz :+ _velz
		
		If posy < -18.0 posy = 18.0
		If posy > 18 posy = -18.0
		If posx < -29.5 posx = 29.5
		If posx > 29.5 posx = -29.5
		obj.moveTo(posx, posy, posz)
			
		If timeMs > _spawnTimeMs + _lifeTimeMs
			Local root:tobject = obj.getroot()
			Local game:tgame = tgame(root._extra)
			
			obj._animators.clear()
			obj.setParent(Null)
			game._alienBullet = obj
		EndIf
	EndMethod
EndType
Type tRotationAnimator Extends tAnimator
	Field _rotx:Float
	Field _roty:Float
	Field _rotz:Float
	
	Method init(rotx:Float, roty:Float, rotz:Float)
		_rotx = rotx
		_roty = roty
		_rotz = rotz
	EndMethod
	
	Method animate(obj:tobject, timeMs:Int)
		obj.rotateTo(obj._rotx + _rotx, obj._roty + _roty, obj._rotz + _rotz)
	EndMethod
EndType

Type tRockAnimator Extends tAnimator
	Field _velx:Float
	Field _vely:Float
	Field _velz:Float
	Field _rotx:Float
	Field _roty:Float
	Field _rotz:Float
	
	Method init(velx:Float, vely:Float, velz:Float, rotx:Float, roty:Float, rotz:Float)
		_velx = velx
		_vely = vely
		_velz = velz
		_rotx = rotx
		_roty = roty
		_rotz = rotz
	EndMethod
	
	Method animate(obj:tobject, timeMs:Int)
		Local posx:Float = obj._posx
		Local posy:Float = obj._posy
		Local posz:Float = obj._posz
		posx :+ _velx; posy :+ _vely; posz :+ _velz
		
		If posy < -18 And _vely <= 0.0 posy = 18
		If posy > 18 And _vely >= 0.0 posy = -18
		If posx < -29.5 And _velx <= 0.0 posx = 29.5
		If posx > 29.5 And _velx >= 0.0 posx = -29.5
		
		obj.moveTo(posx, posy, posz)
		obj.rotateTo(obj._rotx + _rotx, obj._roty + _roty, obj._posz + _rotz)
	EndMethod
EndType

Type tParticleAnimator Extends tAnimator
	Field _velx:Float
	Field _vely:Float
	Field _velz:Float
	Field _rotx:Float
	Field _roty:Float
	Field _rotz:Float
	Field _spawnTimeMs:Int
	Field _lifeTimeMs:Int

	Method init(velx:Float, vely:Float, velz:Float, rotx:Float, roty:Float, rotz:Float, spawnTimeMs:Int, lifeTimeMs:Int)
		_velx = velx
		_vely = vely
		_velz = velz
		_rotx = rotx
		_roty = roty
		_rotz = rotz
		_spawnTimeMs = spawnTimeMs
		_lifeTimeMs = lifeTimeMs
	EndMethod

	Method animate(obj:tobject, timeMs:Int)
		Local posx:Float = obj._posx
		Local posy:Float = obj._posy
		Local posz:Float = obj._posz

		posx :+ _velx
		posy :+ _vely
		posz :+ _velz

		obj.moveTo(posx, posy, posz)
		obj.rotateTo(obj._rotx + _rotx, obj._roty + _roty, obj._posz + _rotz)

		If timeMs > _spawnTimeMs + _lifeTimeMs
			Local root:tobject = obj.getroot()
			Local game:tgame = tgame(root._extra)
			
			obj._animators.clear()
			obj.setParent(Null)
			game._particleStore.addLast(obj)
		EndIf
	EndMethod
EndType

Type tAlienShipControlAnimator Extends tAnimator
	Field _timeMs:Int
	Field _dirTimeMs:Int
	Field _gameActive:Int
	Field _velAnim:tVelocityAnimator
	
	Const SHOT_LIFETIME_MS:Int = 850
	Field _shotLifeTimeMs:Int
	Field _lastShotMs:Int

	Method init(timeMs:Int, gameActive:Int)
		_timeMs = timeMs
		_lastShotMs = timeMs - SHOT_LIFETIME_MS
		_gameActive = gameActive
	EndMethod
	
	Method animate(obj:tObject, timeMs:Int)
		Local root:tobject = obj.getRoot()
		Local game:tGame = tGame(root._extra)

		If _gameActive
			If timeMs > _timeMs + 12000 - game._currentWave * 1000
				' game._alienShip becomes 'NON null' when the alien is active
				If Not game._alien
					' decide which ship to show - show the big one unless...
					game._alien = game._alienBig
					If game._currentWave >= 3 And Rand(0,1) = 0
						game._alien = game._alienLittle
					EndIf
					
					Local alien:tobject = game._alien
					
					' which direction - left or right?
					Local dir:Int = Rand(0,1)
					If dir = 0 dir = -1
					_dirTimeMs = timeMs

					' position ship at the left or right edge
					alien.setParent(game._scene)
					alien.moveTo(30.0 * dir, Rnd(-18.0, 18.0), 0.0)
					
					' make sure to move into the game play area
					_velAnim:tVelocityAnimator = New tVelocityAnimator
					_velanim.init(0.1 * -dir, 0.1 * dir, 0.0)
					alien.addAnimator(_velanim)

					' make it spin
					Local rotate:tRotationAnimator = New tRotationAnimator
					rotate.init(0.0, dir, 0.0)
					alien.addAnimator(rotate)
					
					' earplugs in!
					Local sampleIndexToPlay:Int
					If alien = game._AlienBig
						sampleIndexToPlay = 0
					Else
						sampleIndexToPlay = 1
					EndIf
					game._channelAlien = PlaySound(game._sampleAlien[sampleIndexToPlay])
				EndIf
			EndIf
			
			If game._alien
				' if the bullet is available then shoot once every second
				If game._alienbullet And timeMs > _lastShotMs + SHOT_LIFETIME_MS
					Local bullet:tobject = game._alienbullet
					game._alienbullet = Null

					bullet.setparent(game._scene)
					bullet.moveTo(game._alien._posx, game._alien._posy, game._alien._posz)
					
					Local rot:tRotationAnimator = New tRotationAnimator
					rot.init(-20, 20, -20)
					bullet.addAnimator(rot)
					
					' get a varied vector to the player
					Local accuracy:Float = 20.0 / game._currentWave
					Local dirx:Float = game._ship._posx + Rnd(-accuracy, accuracy) - game._alien._posx
					Local diry:Float = game._ship._posy + Rnd(-accuracy, accuracy) - game._alien._posy
					
					' normalize for consistant speed in all directions
					Local delta:Float = Sqr(dirx * dirx + diry * diry)
					dirx = (dirx / delta) * 0.5
					diry = (diry / delta) * 0.5
					
					' apply
					Local anim:tAlienBulletAnimator = New tAlienBulletAnimator
					anim.init(dirx, diry, 0.0, timeMs, SHOT_LIFETIME_MS)
					bullet.addAnimator(anim)
					
					_lastShotMs = timeMs
					PlaySound(game._sampleAlienShot)
				EndIf
				
				' after 2 seconds change direction
				If timeMs > _dirTimeMs + 2000
					_dirTimeMs = timeMs
					
					Local velx:Float = _velAnim._velx
					game._alien.removeAnimator(_velAnim)
					
					Local diry:Int = Rand(-1, 1)
					_velAnim:tVelocityAnimator = New tVelocityAnimator
					_velanim.init(velx, 0.1 * diry, 0.0)
					game._alien.addAnimator(_velanim)
				EndIf
	
				If game._alien._posy < -18.0 game._alien._posy = 18.0
				If game._alien._posy > 18.0 game._alien._posy = -18.0
				If game._alien._posx < -30.0 Or game._alien._posx > 30.0
					game._alien.setParent(Null)
					game._alien._animators.clear()
					game._alien = Null
					init(timeMs, True)
					StopChannel(game._channelAlien)
				EndIf
			EndIf
		EndIf
	EndMethod
EndType

Type tBombParameterAnimator Extends tAnimator
	Field _val:Float
	
	Method animate(obj:tobject, timeMs:Int)
		Local root:tobject = obj.getRoot()
		If Not root Return

		Local game:tgame = tgame(root._extra)
		
		If _val < 90
			_val :+ 1
			game._bombActive = 1
			game._bombTime = _val
			
			Local matrix:Float[16]
			math.multiplym4m4(game._proj, game._view, matrix)

			Local pos:Float[] = [ game._ship._posx, game._ship._posy, game._ship._posz, 1.0]		
			Local vector:Float[4]
			math.multiplyv4m4(pos, matrix, vector)

			Local px:Float = ( vector[0] / vector[3] ) * 0.5 + 0.5
			Local py:Float = ( vector[1] / vector[3] ) * 0.5 + 0.5

			game._bombCentreX = px * 1200
			game._bombCentreY = 700 - py * 700
		Else
			game._bombActive = False
			game._scene._animators.remove(Self)
		EndIf
	EndMethod
EndType

Type tCollisionHandler
	Method invoke(collisionData:tCollisionData) Abstract
EndType

Type tBulletToRockHandler Extends tCollisionHandler
	Method invoke(collisionData:tCollisionData)
		Local bullet:tobject = collisionData._src
		Local rock:tobject = collisionData._dst
		
		Local root:tobject = rock.getroot()
		Local game:tgame = tgame(root._extra)
		Local size:Int = tobjectrock(rock)._size - 1
		
		' if 'game' is null then we're dealing with a double collision because 2 bullets hit the
		' same rock and it's already been dealt with in here.
		' could probably deal with this in the collision manager but this is also a good place to deal with it
		If Not game Return

		Local scores:Int[] = [100, 50, 20]
		game._score :+ scores[size]

		' remove the bullet
		bullet._animators.clear()
		bullet.setParent(Null)
		game._bulletstore.addlast(bullet)

		game.destroyRock(tobjectRock(rock), collisionData._timeMs)

		' wave complete?
		If game._rocksTodestroy = 0
			Local leaveLevel:tLeaveLevelAnimator = New tLeaveLevelAnimator
			leaveLevel.init(collisionData._timeMs)
			game._scene.addanimator(leaveLevel)
		EndIf
	EndMethod
EndType

Type tShipToRockHandler Extends tCollisionHandler
	Method invoke(collisionData:tCollisionData)
		DebugLog "ShipToRock handler"
	EndMethod
EndType

Type tShipBulletToAlienHandler Extends tCollisionHandler
	Method invoke(collisionData:tCollisionData)
		Local bullet:tobject = collisionData._src
		Local alien:tobject = collisionData._dst
	
		Local root:tobject = bullet.getroot()
		Local game:tgame = tgame(root._extra)
		
		' if 'game' is null then we're dealing with a double collision because 2 bullets hit
		If Not game Return

		game._score :+ 250

		' remove the bullet
		bullet._animators.clear()
		bullet.setParent(Null)
		game._bulletstore.addlast(bullet)

		' remove the alien
		alien._animators.clear()
		alien.setparent(Null)
		game._alien = Null
		game._alienShipController.init(collisionData._timeMs, True)
		
		' if the little alien was shot then drop the upgrade ship or a neutron bomb :)
		If alien = game._alienlittle
			If Not game._powerUp
				Local powerup:tobject
				
				' prioritise getting the upgraded ship before the bomb
				If game._ship = game._shipbasic
					powerup = game._shipPowerUp
				Else
					' give the bomb upgrade
				EndIf
				
				powerUp.setParent(game._scene)
				powerUp.moveTo(alien._posx, alien._posy, alien._posz)
				Local anim:tRotationAnimator = New tRotationAnimator
				anim.init(0.0, -1.0, 0.0)
				powerUp.addAnimator(anim)

				game._powerUp = powerup
			EndIf
		EndIf
		
		' create an explosion
		Local posx:Float = alien._posx
		Local posy:Float = alien._posy
		Local posz:Float = alien._posz

		Local epicentre:tobject = New tobject
		epicentre.setparent(game._scene)
	
		StopChannel(game._channelAlien)
		PlaySound(game._sampleRocks[0])

		For Local i:Int = 0 Until 32
			Local particleanim:tParticleAnimator = New tParticleAnimator
			particleanim.init(Rnd(-0.25,0.25), Rnd(-0.25,0.25), Rnd(-0.25, 0.25), 0.0, 0.0, 0.0, collisionData._timeMs, 200)
			
			Local particle:tobject = tobject(game._particlestore.removefirst())
			If particle
				particle.setParent(game._scene)
				particle.moveTo(posx, posy, posz)
				particle.addAnimator(particleanim)
			EndIf
		Next
	EndMethod
EndType

Type tAlienBulletToShipHandler Extends tCollisionHandler
	Method invoke(collisionData:tCollisionData)
		DebugLog "tAlienBulletToShipHandler"
	EndMethod
EndType

Type tAlienBulletToRockHandler Extends tCollisionHandler
	Method invoke(collisionData:tCollisionData)
		Local rock:tobjectrock = tobjectRock(collisionData._dst)
		Local root:tObject = rock.getRoot()
		If Not root Return
		
		Local game:tgame = tgame(root._extra)
		game.destroyRock(rock, collisionData._timeMs)
		
		' alien could have shot the last rock?
		If game._rocksTodestroy = 0
			Local leaveLevel:tLeaveLevelAnimator = New tLeaveLevelAnimator
			leaveLevel.init(collisionData._timeMs)
			game._scene.addanimator(leaveLevel)
		EndIf

		Local bullet:tobject = collisionData._src
		game._alienBullet = bullet
	EndMethod
EndType

Type tAlienShipToRockHandler Extends tCollisionHandler
	Method invoke(collisionData:tCollisionData)
		Local alien:tobject = collisionData._src
		Local rock:tobjectrock = tobjectrock(collisionData._dst)

		Local root:tobject = alien.getRoot()
		If Not root Return
		
		' split or remove the rock
		Local game:tgame = tgame(root._extra)
		game.destroyRock(rock, collisionData._timeMs)
		
		' remove the alien
		alien._animators.clear()
		alien.setparent(Null)
		game._alien = Null
		game._alienShipController.init(collisionData._timeMs, True)
		
		StopChannel(game._channelAlien)

		' alien could have removed the last rock?
		If game._rocksTodestroy = 0
			Local leaveLevel:tLeaveLevelAnimator = New tLeaveLevelAnimator
			leaveLevel.init(collisionData._timeMs)
			game._scene.addanimator(leaveLevel)
		EndIf
	EndMethod
EndType

Type tShipPowerUpHandler Extends tCollisionHandler
	Method invoke(collisionData:tCollisionData)
		Local ship:tobject = collisionData._src
		Local powerup:tobject = collisionData._dst
		
		Local root:tobject = ship.getRoot()
		If Not root Return
		
		Local game:tgame = tgame(root._extra)
		If powerup = game._shipPowerup
			' copy over attributes
			game._shipupgraded.moveTo(game._ship._posx, game._ship._posy, game._ship._posz)
			game._shipupgraded.rotateTo(game._ship._rotx, game._ship._roty, game._ship._rotz)
			game._shipupgraded.setParent(game._ship._parent)
			
			' remove old ship from gameplay
			game._ship.setParent(Null)
			game._ship = game._shipupgraded
		EndIf
		
		PlaySound(game._sampleUpgrade)
		
		' remove the powerup
		powerup._animators.clear()
		powerup.setparent(Null)
		game._powerup = Null
	EndMethod
EndType

Type tCollisionType
	Field _src:Int
	Field _dst:Int
	Field _handler:tCollisionHandler
	
	Method Create:tCollisionType(src:Int, dst:Int, handler:tCollisionHandler)
		_src = src
		_dst = dst
		_handler = handler

		Return Self
	EndMethod
EndType

Type tCollisionData
	Field _src:tobject
	Field _dst:tobject
	Field _timeMs:Int
	
	Method Create:tCollisionData(src:tObject, dst:tobject, timeMs:Int)
		_src = src
		_dst = dst
		_timeMs = timeMs

		Return Self
	EndMethod
EndType

Type tCollisionManager Extends tAnimator
	Field _collisionTypes:tCollisionType[]
	Field _collisions:TList = New TList
	
	Method addCollidableIds(src:Int, dst:Int, handler:tCollisionHandler)
		Local found:Int
		For Local colliderType:tCollisionType = EachIn _collisionTypes
			If colliderType._src = src And colliderType._dst = dst found = True
		Next
		
		If Not found
			_collisionTypes :+ [New tCollisionType.Create(src, dst, handler)]
		EndIf
	EndMethod
	
	Method animate(obj:tobject, timeMs:Int)
		For Local collisionType:tCollisionType = EachIn _collisionTypes
			_collisions.clear()
			
			For Local src:tObject = EachIn obj._children
				checkCollisions(src, collisionType, timeMs)
			Next
			
			For Local collision:tCollisionData = EachIn _collisions
				If collisionType._handler collisionType._handler.invoke(collision)
			Next
		Next
	EndMethod

	Method checkcollisions(obj:tobject, collisionType:tCollisionType, timeMs:Int)
		For Local src:tObject = EachIn obj._children
			If src._collisionId <> collisionType._src Continue

			For Local dst:tobject = EachIn obj._children
				If dst._collisionId <> collisionType._dst Continue

				' hmm choose type of collision detection to use? simple spheres at the mo
				Local srcPosx:Float = src._posx
				Local srcPosy:Float = src._posy
				Local srcPosz:Float = src._posz
				
				Local dstPosx:Float = dst._posx
				Local dstPosy:Float = dst._posy
				Local dstPosz:Float = dst._posz

				' get the distance from src to dst
				Local dx:Float = dstPosx - srcPosx
				Local dy:Float = dstPosy - srcPosy
				Local dz:Float = dstPosz - srcPosz
				
				Local dist:Float = dx * dx + dy * dy + dz * dz

				Local radii:Float = (src._collisionRadius + dst._collisionRadius)
				radii :* radii

				If radii >= dist _collisions.addLast(New tCollisionData.Create(src, dst, timeMs))
			Next
		Next
	EndMethod
EndType

AppTitle = "Star-Roids"

SeedRnd(MilliSecs() * MilliSecs())
HideMouse()
Local game:tGame = New tGame
game.init(1200, 700)
game.run()
game.shutdown()











