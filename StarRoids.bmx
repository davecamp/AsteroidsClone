
Strict

Import pub.win32
Import srs.directx11

Const RENDERFLAG_SOLID:Int = 1
Const RENDERFLAG_WIREFRAME:Int = 2

Global shipMeshData:String
shipMeshData :+ "linelist~n"
shipMeshData :+ "v -0.5 -0.8 0.0~n"
shipMeshData :+ "v 0.0 0.8 0.0~n"
shipMeshData :+ "v 0.5 -0.8 0.0~n"
shipMeshData :+ "v 0.25 -0.5 0.0~n"
shipMeshData :+ "v -0.25 -0.5 0.0~n"
shipMeshData :+ "v 0.0 0.2 0.0~n"
shipMeshData :+ "v 0.0 -0.3 0.0~n"
shipMeshData :+ "f 0 1 1 2 2 3 3 4 4 0 5 6"

Global bulletMeshData:String
bulletMeshData :+ "linelist~n"
bulletMeshData :+ "v -0.03 -0.03 0.0~n"
bulletMeshData :+ "v -0.03 0.03 0.0~n"
bulletMeshData :+ "v 0.03 0.03 0.0~n"
bulletMeshData :+ "v 0.03 -0.03 0.0~n"
bulletMeshData :+ "f 0 1 2 3 0~n"

Global particleMeshData:String
particleMeshData :+ "linelist~n"
particleMeshData :+ "v -0.02 -0.02 0.0~n"
particleMeshData :+ "v -0.02 0.02 0.0~n"
particleMeshData :+ "v 0.02 0.02 0.0~n"
particleMeshData :+ "v 0.02 -0.02 0.0~n"
particleMeshData :+ "f 0 1 2 3 0~n"

Type tAsteroid	
	Method Create:String()
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
	Method Create:String()
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
		
		For Local ang:Float = 0.0 Until 360.0 Step 0.2
			Local random:Float = Rnd(-ringsize * 0.5, ringsize * 0.5)
			Local randomradius:Float = radius + random

			Local posx:Float = (randomradius - radius * 0.1) * Sin(ang)
			Local posy:Float = (randomradius - radius * 0.1) * Cos(ang)
			Local posz:Float = Rnd(-ringsize * 0.5, ringsize * 0.5)
			meshdata :+ "v " + posx + " " + posy + " " + posz + "~n"
		Next
		
		meshdata :+ "f"
		For Local i:Int = 0 Until 1800 + 360
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
		_glyphs[2] = New tGlyph.Create([4, 14, 14, 11, 11, 1, 1, 0, 0, 10])   ' 2
		_glyphs[3] = New tGlyph.Create([4, 14, 14, 10, 10, 0, 11, 1])         ' 3
		_glyphs[4] = New tGlyph.Create([4, 1, 1, 11, 10, 14])                 ' 4
		_glyphs[5] = New tGlyph.Create([14, 4, 4, 1, 1, 11, 11, 10, 10, 0])   ' 5
		_glyphs[6] = New tGlyph.Create([4, 0, 0, 10, 10, 11, 11, 1])          ' 6
		_glyphs[7] = New tGlyph.Create([4, 14, 14, 10])                       ' 7
		_glyphs[8] = New tGlyph.Create([0, 4, 4, 14, 14, 10, 10, 0, 1, 11])   ' 8
		_glyphs[9] = New tGlyph.Create([10, 14, 14, 4, 4, 1, 1, 11])          ' 9

		' A to Z
		_glyphs[10] = New tGlyph.Create([0, 1, 1, 9, 9, 11, 11, 10, 1, 11])       ' A
		_glyphs[11] = New tGlyph.Create([0, 4, 4, 9, 9, 13, 13, 7, 7, 11, 11, 5, 5, 0, 2, 7])  ' B
		_glyphs[12] = New tGlyph.Create([10, 0, 0, 4, 4, 14])                     ' C
		_glyphs[13] = New tGlyph.Create([0, 4, 4, 9, 9, 13, 13, 11, 11, 5, 5, 0]) ' D
		_glyphs[14] = New tGlyph.Create([10, 0, 0, 4, 4, 14, 1, 6])               ' E
		_glyphs[15] = New tGlyph.Create([0, 4, 4, 14, 2, 7])                      ' F
		_glyphs[16] = New tGlyph.Create([14, 4, 4, 0, 0, 10, 10, 11, 11, 6])      ' G
		_glyphs[17] = New tGlyph.Create([0, 4, 10, 14, 1, 11])                    ' H
		_glyphs[18] = New tGlyph.Create([4, 14, 0, 10, 5, 9])                     ' I
		_glyphs[19] = New tGlyph.Create([4, 14, 14, 10, 10, 5, 5, 1])             ' J
		_glyphs[20] = New tGlyph.Create([0, 4, 1, 14, 1, 10])                     ' K
		_glyphs[21] = New tGlyph.Create([4, 0, 0, 10])                            ' L
		_glyphs[22] = New tGlyph.Create([0, 4, 4,  8, 8, 14, 14, 10])             ' M
		_glyphs[23] = New tGlyph.Create([0, 4, 4, 10, 10, 14])                    ' N
		_glyphs[24] = New tGlyph.Create([0, 4, 4, 14, 14, 10, 10, 0])             ' O
		_glyphs[25] = New tGlyph.Create([0, 4, 4, 14, 14, 13, 13, 3])             ' P
		_glyphs[26] = New tGlyph.Create([0, 4, 4, 14, 14, 11, 11, 5, 5, 0, 6, 10]) ' Q
		_glyphs[27] = New tGlyph.Create([0, 4, 4, 14, 14, 11, 11, 1, 1, 10])      ' R
		_glyphs[28] = New tGlyph.Create([14, 4, 4, 1, 1, 11, 11, 10, 10, 0])      ' S
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
				' use i as an offset to push each letter to the right
				Local vertex:Float[] = [ _vertices[index * 3 + 0] + x + 0.5, _vertices[index * 3 + 1] + y + 0.5, _vertices[index * 3 + 2] ]
				mesh._vertices :+ vertex
			Next
			
			x :+ 1
		Next
		
		mesh._indices = New Int[mesh._vertices.length]
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
		state.DepthBias = -100
		
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

	Method Cls(colour:Float[])
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
	
	Field _view:Float[16]
	Field _proj:Float[16]
	Field _model:Float[16]
	
	Field _root:tobject
	Field _scene:tobject
	Field _gui:tobject

	Field _ship:tobject
	Field _rockstore:TList
	
	Field _particleStore:TList
	
	Field _font:tFont
	Field _copyright:tobject
	Field _pressToStart:tobject
	Field _title:tobject
	Field _titlebelt:tobject

	Field _bulletstore:TList
	
	Const COLLISION_ID_SHIP:Int = 1
	Const COLLISION_ID_BULLET:Int = 2
	Const COLLISION_ID_ROCK:Int = 3

	Method init(Width:Int, Height:Int)
		_particleStore = New TList
		_bulletstore = New TList
		_rockstore = New TList
		
		' setup root
		_root = New tobject
		_root.setname("root")
		_root.setExtra(Self)
		
		Local collisionManager:tCollisionManager = New tCollisionManager
		collisionManager.addCollidableIds(COLLISION_ID_SHIP, COLLISION_ID_ROCK)
		collisionManager.addCollidableIds(COLLISION_ID_BULLET, COLLISION_ID_ROCK)
		_root.addAnimator(collisionManager)
		
		' setup the game scene object
		_scene = New tobject
		_scene.setparent(_root)
		_scene.setname("scene")

		' setup the gui object
		_gui = New tObject
		_gui.setParent(_root)
		_gui.setname("gui")

		_window = New TWindow.Create(Width, Height)
		_pipeline = New TGpuD3D11.Create(Width, Height, _window.getWindowHandle())
	
		_view = [1.0, 0.0, 0.0, 0.0,..
		         0.0, 1.0, 0.0, 0.0,..
				 0.0, 0.0, 1.0, 60.0,..
				 0.0, 0.0, 0.0, 1.0]
		
		createShaderResources()
		createGameObjects()
	EndMethod
	
	Method createGameObjects()
		_font = New tFont
		
		' title
		Local msg:String = "StarRoids"
		_title = New tobject
		_title.setparent(_gui)
		_title.moveTo(0, 7, 0)
		_title.setname("title")

		Local titleMesh:tmesh = _font.createsentence(msg)
		titlemesh.scale(2, 2, 2)

		Local titleObject:tobject = New tObject.Create(_pipeline._device, titleMesh, _title, RENDERFLAG_WIREFRAME)
		titleObject.moveto( -Float(msg.length), -.5, 0)
		titleobject.setname("titleobject")
		
		' planet
		Local planetdata:String = New tasteroid.Create()
		Local planetmesh:tmesh = parsemeshdata(planetdata, 4)
		Local planetobject:tobject = New tobject.Create(_pipeline._device, planetmesh, _scene, RENDERFLAG_SOLID | RENDERFLAG_WIREFRAME)
		planetobject.setname("planet")
		planetobject.moveTo(0.0, 5.5, 0.0)

		Local planetrotation:tRotationAnimator = New tRotationAnimator
		planetrotation.init(0.0, -0.1, 0.0)
		planetobject.addAnimator(planetrotation)
		planetobject.setcolour(0.3, 0.3, 0.3, 1.0)

		' logo asteroid belt
		Local titlebeltmeshdata:String = New tasteroidbelt.Create()
		Local titlebeltmesh:tmesh = parsemeshdata(titlebeltmeshdata, 1.0)
		
		Local test:tobject = New tobject
		test.setparent(_scene)
		test.rotateTo(120.0, 0.0, 0.0)
		test.moveTo(0.0, 5.5, 0.0)
		test.setname("test")
		_titlebelt = New tobject.Create(_pipeline._device, titlebeltmesh, test, RENDERFLAG_WIREFRAME)
		_titlebelt.setColour(0.6, 0.6, 0.6, 1.0)
		_titlebelt.setname("title asteroid belt")

		Local rotation:tRotationAnimator = New tRotationAnimator
		rotation.init(0.0, 0.0, 0.1)
		_titlebelt.addAnimator(rotation)

		' press to start
		msg = "press space to play"
		_pressToStart = New tobject
		_pressToStart.setparent(_gui)
		_pressToStart.moveTo(0, -4, 0)
		_pressToStart.addAnimator(New tIntroAnimator)
		_pressToStart.setname("pressstart")
	
		Local pressToStartMesh:tmesh = _font.createsentence(msg)
		Local pressToStartObject:tobject = New tObject.Create(_pipeline._device, pressToStartMesh, _pressToStart, RENDERFLAG_WIREFRAME)
		pressToStartObject.moveto( -Float(msg.length)/2, -.5, 0)
		pressToStartObject.setName("presstostartobject")

		' create copyright for atari
		_copyright = New tobject
		_copyright.setparent(_gui)
		_copyright.moveTo(0, -21, 25)
		_copyright.setname("copyright")
		
		msg = "original game idea by atari inc 1979"
		Local textmesh:tmesh = _font.createSentence(msg)
		Local text:tobject = New tObject.Create(_pipeline._device, textmesh, _copyright, RENDERFLAG_WIREFRAME)
		text.moveto( -Float(msg.length)/2, -.5, 0)
		test.setname("copyrighttext")
	
		Local textRoller:tRollAnimator = New tRollAnimator
		textRoller.init(5000, 3000, MilliSecs())
		_copyright.addAnimator(textRoller)

		' create ship
		Local shipmesh:tmesh = parsemeshdata(shipMeshData, 1)
		_ship = New tobject.Create(_pipeline._device, shipmesh, Null, RENDERFLAG_WIREFRAME)
		_ship.setName("ship")
		Local shipAnimator:tShipAnimator = New tShipAnimator
		_ship.addAnimator(shipAnimator)
		_ship.setCollisionId(COLLISION_ID_SHIP)
		_ship.setCollisionRadius(0.7)
		
		' create bullets
		Local bulletMesh:tMesh = parsemeshdata(bulletMeshData, 1.0)
		For Local i:Int = 0 Until 10
			Local bullet:tobject = New tobject.Create(_pipeline._device, bulletMesh, Null, RENDERFLAG_WIREFRAME)
			bullet.setCollisionId(COLLISION_ID_BULLET)
			bullet.setCollisionRadius(0.05)
			_bulletstore.addlast(bullet)
		Next
		
		' create some explosion particles
		Local particleMesh:tmesh = parsemeshdata(particleMeshData, Rnd(1.0, 2.0))
		For Local i:Int = 0 Until 256
			Local particle:tobject = New tobject.Create(_pipeline._device, particleMesh, Null, RENDERFLAG_WIREFRAME)
			_particleStore.addLast(particle)
		Next
		
		createRocks()
	EndMethod

	Method createRocks()
		Local rockdata:String = New tasteroid.Create()
		
		' create 16 big rocks
		For Local i:Int = 0 Until 16
			Local rockmesh:tmesh = parsemeshdata(rockdata, 1.0)
			Local rock:tobject = New tobjectrock.Create(_pipeline._device, rockmesh, Null, RENDERFLAG_SOLID | RENDERFLAG_WIREFRAME)
			rock.setCollisionId(COLLISION_ID_ROCK)
			rock.setCollisionRadius((1.0 + Sqr(5.0)) / 2.0)
			
			tobjectrock(rock).setSize(3)			
			_rockstore.addLast(rock)
		Next
		
		' 32 middle size
		For Local i:Int = 0 Until 32
			Local rockmesh:tmesh = parsemeshdata(rockdata, 0.6)
			Local rock:tobject = New tobjectrock.Create(_pipeline._device, rockmesh, Null, RENDERFLAG_SOLID | RENDERFLAG_WIREFRAME)
			rock.setCollisionId(COLLISION_ID_ROCK)
			rock.setCollisionRadius(((1.0 + Sqr(5.0)) / 2.0) * 0.6)
			
			tobjectrock(rock).setSize(2)
			_rockstore.addLast(rock)
		Next

		'  64 small - should be waaay more than enough
		For Local i:Int = 0 Until 64
			Local rockmesh:tmesh = parsemeshdata(rockdata, 0.3)
			Local rock:tobject = New tobjectrock.Create(_pipeline._device, rockmesh, Null, RENDERFLAG_SOLID | RENDERFLAG_WIREFRAME)
			rock.setCollisionId(COLLISION_ID_ROCK)
			rock.setCollisionRadius(((1.0 + Sqr(5.0)) / 2.0) * 0.3)
			
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
	
	Method getBullet:tobject()
		Return tobject(_bulletstore.removefirst())
	EndMethod
	
	Method getParticle:tobject()
		Return tobject(_particlestore.removefirst())
	EndMethod
	
	Method returnBullet(bullet:tobject)
		_bulletstore.addlast(bullet)
	EndMethod
	
	Method returnRock(rock:tobject)
		_rockstore.addlast(rock)
	EndMethod
	
	Method returnParticle(rock:tobject)
		_particlestore.addlast(rock)
	EndMethod


	Method parsemeshdata:tmesh(data:String, scale:Float)
		Local lines:String[] = data.split("~n")
		Local mesh:tmesh = New tmesh

		For Local line:String = EachIn lines
			Local comp:String[] = line.split(" ")

			Select comp[0]
			Case "pointlist" mesh._topology = D3D11_PRIMITIVE_TOPOLOGY_POINTLIST
			Case "linelist"	mesh._topology = D3D11_PRIMITIVE_TOPOLOGY_LINELIST
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
		If Not _vsConstants DebugLog " cannot create buffer for vertex shader per frame constants"
		
		' pixel shader constants - per frame
		desc.ByteWidth = 16
		_pipeline._device.createBuffer(desc, Null, _psConstants)
		If Not _vsConstants DebugLog " cannot create buffer for pixel shader per frame constants"
		
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
		If Not _inputLayout DebugLog " cannot create input layout"

		' vertex shader
		_pipeline._device.createVertexShader(pShaderByteCode, shaderByteCodeLength, Null, _vertexShader)
		If Not _vertexShader DebugLog " cannot create vertex shader"
	
		' compile and create pixel shader
		shaderByteCodeLength = pixelshaderByteCode.getBufferSize()
		pShaderByteCode = pixelshaderByteCode.getBufferPointer()

		_pipeline._device.createPixelShader(pShaderByteCode, shaderByteCodeLength, Null, _pixelShader)
		If Not _pixelShader DebugLog " cannot create pixel shader"

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
			DebugLog String.FromCString(error.getBufferPointer())
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
		source :+ "   float3 pos : POSITION;~n"
		source :+ "};~n"
		
		source :+ "struct PSINPUT{~n"
		source :+ "   float4 pos : SV_POSITION;~n"
		source :+ "};~n"
		
		source :+ "PSINPUT VSMain(VSINPUT vsIn){~n"
		source :+ "   PSINPUT vsOut;~n"

		source :+ "   float4x4 viewproj = mul(view, proj);~n"
		source :+ "   float4 posWorld = mul(float4(vsIn.pos, 1.0f), model);~n"
		source :+ "   vsOut.pos = mul(posWorld, viewproj);~n"

		source :+ "   return vsOut;~n"
		source :+ "}~n"
		
		source :+ "cbuffer perFrame{~n"
		source :+ "    float4 colour;~n"
		source :+ "}~n"
		source :+ "float4 PSMain(PSINPUT psIn) : SV_Target{~n"
		source :+ "    return colour;~n"
		source :+ "};~n"

		Return source
	EndMethod
	
	Method run()						
		_pipeline.setWireframeOn()
		_pipeline._context.IASetInputLayout(_inputLayout)
		_pipeline._context.PSSetConstantBuffers(0, 1, Varptr _psConstants)

		set3DProjection(30.0, 1200.0 / 700.0, 0.1, 1000.0)

		While Not AppTerminate()
			Select _gamestate
			Case -1 Exit
			Case 0 updateintro()
			Case 1 updategame()
			EndSelect
		Wend
	EndMethod
	
	Method beginGameLevel(level:Int)
		_ship.setparent(_gui)

		SeedRnd(MilliSecs() * MilliSecs())
		For Local i:Int = 0 Until 4		
			Local rock:tobject = getRock(3)
			If rock
				rock.setparent(_gui)
				rock.moveTo(Rnd(-20, 20), 14 + Rnd(-1, 1), 0)
	
				' big rock will move slower
				Local rockanim:tRockAnimator = New tRockAnimator
				rockanim.init(Rnd(-0.05, 0.05), Rnd(-0.05, 0.0), 0.0,  Rnd(-1, 1), Rnd(-1, 1), Rnd(-1, 1))
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

		_root.update(timeMs:Int)
	EndMethod
	
	Method rendergame()
			_pipeline.Cls([0.0, 0.0, 0.0, 1.0])
			
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
			rendergui()
			
			_pipeline.Present(True)
	EndMethod
	
	Method rendersolids(scene:tobject)
		' render scene as black
		Local colour:Float[] = [0.0, 0.0, 0.0, 1.0]
		
		Local map:D3D11_MAPPED_SUBRESOURCE = New D3D11_MAPPED_SUBRESOURCE
		_pipeline._context.Map(_psConstants, 0, D3D11_MAP_WRITE_DISCARD, 0, map)
		MemCopy(map.pData, colour, 16)
		_pipeline._context.Unmap(_psConstants, 0)
		_pipeline._context.PSSetConstantBuffers(0, 1, Varptr _psConstants)
		
		' turn on depth testing and solid rendering
		_pipeline.setWireframeOff()
		scene.renderSolid(_pipeline._context)
	EndMethod
	
	Method renderwireframes(scene:tobject)
		' render scene as white wireframe			
		Local colour:Float[] = [1.0, 1.0, 1.0, 1.0]
		
		Local map:D3D11_MAPPED_SUBRESOURCE = New D3D11_MAPPED_SUBRESOURCE
		_pipeline._context.Map(_psConstants, 0, D3D11_MAP_WRITE_DISCARD, 0, map)
		MemCopy(map.pData, colour, 16)
		_pipeline._context.Unmap(_psConstants, 0)

		_pipeline.setWireframeOn()
		scene.renderWireframe(_pipeline._context)
	EndMethod
	
	Method renderscene()
		_pipeline.turnOnDepthTesting()
		rendersolids(_scene)
		renderwireframes(_scene)
	EndMethod
	
	Method rendergui()
		_pipeline.turnOffDepthTesting()
		rendersolids(_gui)
		renderwireframes(_gui)
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
	Field _collisionResponder:tCollisionResponder
	
	Field _colour:Float[4]
	Field _renderFlag:Int

	Method New()
		_animators = New TList
		_children = New TList
		math.identitym4(_local)
		math.identitym4(_world)
		
		_colour = [1.0, 1.0, 1.0, 1.0]
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
		If Not _vertexBuffer DebugLog " cannot create vertex buffer"

		' index buffer
		desc.ByteWidth = SizeOf(mesh._indices)
		desc.BindFlags = D3D11_BIND_INDEX_BUFFER
		
		data.pSysMem = mesh._indices
		
		device.createBuffer(desc, data, _indexBuffer)
		If Not _indexBuffer DebugLog " cannot create index buffer"

		' world buffer
		desc.ByteWidth = 64
		desc.Usage = D3D11_USAGE_DYNAMIC
		desc.BindFlags = D3D11_BIND_CONSTANT_BUFFER
		desc.cpuAccessFlags = D3D11_CPU_ACCESS_WRITE

		device.createBuffer(desc, Null, _worldBuffer)
		If Not _worldBuffer DebugLog " cannot create world constant buffer"

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
	
	Method setCollisionResponder(responder:tCollisionResponder)
		_collisionResponder = responder
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
	
	Method setColour(r:Float, g:Float, b:Float, a:Float)
		_colour[0] = r; _colour[1] = g; _colour[2] = b; _colour[3] = a
	EndMethod
	
	Method renderSolid(context:ID3D11DeviceContext)
		If _renderflag & RENDERFLAG_SOLID
			' everything rendered solid is black
			Local root:tobject = getRoot()
			Local game:tgame = tgame(root._extra)
			
			Local map:D3D11_MAPPED_SUBRESOURCE = New D3D11_MAPPED_SUBRESOURCE
			context.Map(game._psConstants, 0, D3D11_MAP_WRITE_DISCARD, 0, map)
			MemCopy(map.pData, [0.0, 0.0, 0.0, 1.0], 16)
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
			MemCopy(map.pData, _colour, 16)
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

Type tanimator
	Method animate(obj:tobject, timeMs:Int) Abstract
EndType

Type tIntroAnimator Extends tAnimator
	Method animate(obj:tobject, timeMs:Int)
		If KeyDown(KEY_SPACE)
			FlushKeys()
			
			Local root:tobject = obj.getroot()
			Local game:tGame = tGame(root._extra)
			game._gamestate = 1
			
			game._pressToStart.setParent(Null)
			game._title.setparent(Null)
			game.BeginGameLevel(1)
		EndIf
	EndMethod
EndType

Type tGamePlayAnimator Extends tAnimator
	Method animate(obj:tobject, timeMs:Int)
	EndMethod
EndType

Type tRollAnimator Extends tanimator
	Field _lastTimeMs:Int
	Field _nextTimeMs:Int
	Field _timeToRollMs:Int
	Field _timeToWaitMs:Int
	Field _state:Int				' 0 is idle, 1 is rotating

	Method init(waitTimeMs:Int, timeToRollMs:Int, initTimeMs:Int)
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
			obj.rotateTo(ang, 0, 0)
			
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
		Local st:Float = 5
		If KeyDown(KEY_LEFT) obj.rotateTo(obj._rotx, obj._roty, obj._rotz - st)
		If KeyDown(KEY_RIGHT) obj.rotateTo(obj._rotx, obj._roty, obj._rotz + st)
			
		' adjust  some thrust
		If KeyDown(KEY_UP)
			_velx :+ 0.01 * Sin(obj._rotz)
			_vely :+ 0.01 * Cos(obj._rotz)
			
			_velx = Max(-0.6, Min(_velx, 0.6))
			_vely = Max(-0.6, Min(_vely, 0.6))
		EndIf
		
		Local posx:Float = obj._posx
		Local posy:Float = obj._posy
		Local posz:Float = obj._posz
		posx :+ _velx; posy :+ _vely; posz :+ _velz
		
		If posy < -18.0 posy = 18.0
		If posy > 18 posy = -18.0
		If posx < -30 posx = 30
		If posx > 30 posx = -30
		obj.moveTo(posx, posy, posz)

		If KeyHit(KEY_SPACE)
			Local root:tobject = obj.getroot()
			Local game:tgame = tgame(root._extra)

			If Not game._bulletstore.isempty()
				Local velx:Float = Sin(obj._rotz)
				Local vely:Float = Cos(obj._rotz)
				Local bullet:tobject = game.getBullet()
				If bullet
					Local animator:tBulletAnimator = New tBulletAnimator
					animator.init(velx, vely, 0.0, 500, timeMs)
		
					bullet.addAnimator(animator)
					bullet.setParent(game._gui)
					bullet.moveTo(obj._posx + velx, obj._posy + vely, 0.0)
					bullet.setCollisionResponder(New tBulletToRockResponder)
				EndIf
			EndIf
		EndIf	
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
		If posx < -30 posx = 30
		If posx > 30 posx = -30
		obj.moveTo(posx, posy, posz)
			
		If timeMs > _spawnTimeMs + _lifeTimeMs
			Local root:tobject = obj.getroot()
			Local game:tgame = tgame(root._extra)
			
			obj._animators.clear()
			obj.setParent(Null)
			game.returnBullet(obj)
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

Type tVelocityAnimator Extends tAnimator
	Field _velx:Float
	Field _vely:Float
	Field _velz:Float

	Method init(velx:Float, vely:Float, velz:Float)
		_velx = velx
		_vely = vely
		_velz = velz
	EndMethod
	
	Method animate(obj:tobject, timeMs:Int)
		Local posx:Float = obj._posx
		Local posy:Float = obj._posy
		Local posz:Float = obj._posz
		posx :+ _velx; posy :+ _vely; posz :+ _velz
		
		If posy < -18.0 posy = 18.0
		If posy > 18 posy = -18.0
		If posx < -30 posx = 30
		If posx > 30 posx = -30
		
		obj.moveTo(posx, posy, posz)
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
		
		If posy < -18.0 posy = 18.0
		If posy > 18 posy = -18.0
		If posx < -30 posx = 30
		If posx > 30 posx = -30
		
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
			game.returnParticle(obj)
		EndIf
	EndMethod
EndType

Type tCollisionResponder
	Method collisionWith(collisionData:tCollision) Abstract
EndType

Type tBulletToRockResponder Extends tCollisionResponder
	Method collisionWith(collisionData:tCollision)
		Local bullet:tobject = collisionData._src
		Local rock:tobject = collisionData._dst
		
		Local root:tobject = rock.getroot()
		Local game:tgame = tgame(root._extra)
		Local size:Int = tobjectrock(rock)._size - 1

		' remove the bullet
		bullet._animators.clear()
		bullet.setParent(Null)
		game.returnBullet(bullet)

		' remove the rock
		rock._animators.clear()
		rock.setparent(Null)
		game.returnRock(rock)
		
		' create an explosion
		Local posx:Float = rock._posx
		Local posy:Float = rock._posy
		Local posz:Float = rock._posz

		Local epicentre:tobject = New tobject
		epicentre.setparent(game._scene)

		For Local i:Int = 0 Until 32
			Local particleanim:tParticleAnimator = New tParticleAnimator
			particleanim.init(Rnd(-0.5,0.5), Rnd(-0.5,0.5), 0.0, 0.0, 0.0, 0.0, collisionData._timeMs, 800)
			
			Local particle:tobject = game.getParticle()
			If particle
				particle.setParent(game._gui)
				particle.moveTo(posx, posy, posz)
				particle.addAnimator(particleanim)
			EndIf
		Next
			
		' split the rock into 2
		If size <> 0
			For Local i:Int = 0 Until 3
				Local rock:tobjectrock = tobjectrock(game.getRock(size))
				If rock
					rock.moveTo(posx, posy, posz)
					rock.setparent(game._gui)
				
					Local rockanim:tRockAnimator = New tRockAnimator
					rockanim.init(Rnd(-0.1, 0.1), Rnd(-0.1, 0.1), 0.0,  Rnd(-1, 1), Rnd(-1, 1), Rnd(-1, 1))
					rock.addAnimator(rockanim)
				EndIf
			Next
		EndIf
	EndMethod
EndType

Type tCollisionType
	Field _src:Int
	Field _dest:Int
	
	Method Create:tCollisionType(src:Int, dest:Int)
		_src = src
		_dest = dest
		Return Self
	EndMethod
EndType

Type tCollision
	Field _src:tobject
	Field _dst:tobject
	Field _timeMs:Int
	
	Method Create:tCollision(src:tObject, dst:tobject, timeMs:Int)
		_src = src
		_dst = dst
		_timeMs = timeMs

		Return Self
	EndMethod
EndType

Type tCollisionManager Extends tAnimator
	Field _collisionTypes:tCollisionType[]
	Field _collisions:TList = New TList
	
	Method addCollidableIds(src:Int, dest:Int)
		Local found:Int
		For Local colliderType:tCollisionType = EachIn _collisionTypes
			If colliderType._src = src And colliderType._dest = dest found = True
		Next
		
		If Not found
			_collisionTypes :+ [New tCollisionType.Create(src, dest)]
		EndIf
	EndMethod
	
	Method animate(obj:tobject, timeMs:Int)
		_collisions.clear()

		For Local collisionType:tCollisionType = EachIn _collisionTypes
			For Local src:tObject = EachIn obj._children
				checkCollisions(src, collisionType, timeMs)
			Next
		Next

		For Local collision:tCollision = EachIn _collisions
			If collision._src._collisionResponder
				collision._src._collisionResponder.collisionWith(collision)
			EndIf
		Next
	EndMethod
	
	Method checkcollisions(obj:tobject, collisionType:tCollisionType, timeMs:Int)
		For Local src:tObject = EachIn obj._children
			If src._collisionId <> collisionType._src Continue
			
			For Local dst:tobject = EachIn obj._children
				If dst._collisionId <> collisionType._dest Continue
				
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
				
				Local dist:Float = dx * dx + dy * dy + dz *dz

				Local radii:Float = (src._collisionRadius + dst._collisionRadius)
				radii :* radii

				If radii > dist _collisions.addLast(New tCollision.Create(src, dst, timeMs))
			Next
		Next
	EndMethod
EndType

AppTitle = "Star-Roids"

HideMouse()
Local game:tGame = New tGame
game.init(1200, 700)
game.run()
game.shutdown()











