
Strict

Import pub.win32
Import srs.directx11

Type TWindow
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

Type TGpuD3D11
	Field _device:ID3D11Device
	Field _context:ID3D11DeviceContext
	Field _swapchain:IDXGISwapchain
	
	Field _rasterstateWireframe:ID3D11RasterizerState
	Field _rasterstateSolid:ID3D11RasterizerState

	Field _backbufferView:ID3D11RendertargetView
	Field _depthstencilView:ID3D11DepthstencilView

	Method Create:TGpuD3D11(Width:Int, Height:Int, WindowHandle:Byte Ptr)
		createDeviceAndSwapchain(Width, Height, WindowHandle)
		createDepthtarget(Width, Height)
		createBackbuffer()
		createRasterizerState()
		
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
		
		_device.CreateRasterizerState(state, _rasterstateWireframe)
		If Not _rasterstateWireframe Throw " could not create rasterizer state"
	EndMethod
	
	Method setDefaults(Width:Int, Height:Int)
		_context.IASetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_TRIANGLELIST)
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
		_context.RSSetState(_rasterStateWireframe)
	EndMethod
	
	Method SetWireframeOff()
		_context.RSSetState(_rasterStateSolid)
	EndMethod
EndType

Type tGame
	Field _window:TWindow
	Field _pipeline:TGpuD3D11
	
	Field _vertexConstantBufferPerFrame:ID3D11Buffer
	Field _vertexConstantBufferPerObject:ID3D11Buffer
	
	Field _inputLayout:ID3D11InputLayout
	Field _vertexShader:ID3D11VertexShader
	Field _pixelShader:ID3D11PixelShader
	
	Field _indexBuffer:ID3D11Buffer
	Field _vertexBuffer:ID3D11Buffer
	
	Field _proj:Float[16]
	
	Method init(Width:Int, Height:Int)
		_window = New TWindow.Create(Width, Height)
		_pipeline = New TGpuD3D11.Create(Width, Height, _window.getWindowHandle())
		
		createShaderResources()
		createGameObjects()
	EndMethod
	
	Method createGameObjects()
		Local verts:Float[] = [ -1.0, -1.0, 0.0,..
								-1.0,  1.0, 0.0,..
								 1.0,  1.0, 0.0,..
								 1.0, -1.0, 0.0]
		
		Local indices:Int[] = [	0, 1, 2,..
								0, 2, 3]
	
		' vertex buffer
		Local desc:D3D11_BUFFER_DESC = New D3D11_BUFFER_DESC
		desc.ByteWidth = SizeOf(verts)
		desc.Usage = D3D11_USAGE_DEFAULT
		desc.BindFlags = D3D11_BIND_VERTEX_BUFFER

		Local data:D3D11_SUBRESOURCE_DATA = New D3D11_SUBRESOURCE_DATA
		data.pSysMem = verts
		
		_pipeline._device.createBuffer(desc, data, _vertexBuffer)
		If Not _vertexBuffer DebugLog " cannot create vertex buffer"
		
		' index buffer
		desc.ByteWidth = SizeOf(indices)
		desc.BindFlags = D3D11_BIND_INDEX_BUFFER
		
		data.pSysMem = indices
		
		_pipeline._device.createBuffer(desc, data, _indexBuffer)
		If Not _indexBuffer DebugLog " cannot create index buffer"
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
		
		_proj = [    xs, 0.0, 0.0, 0.0,..
					0.0, ys,  0.0, 0.0,..
					0.0, 0.0, far/range, -near * far / range,..
					0.0, 0.0, 1.0, 0.0]
	EndMethod
	
	Method createShaderResources()
		' constants - per frame
		Local desc:D3D11_BUFFER_DESC = New D3D11_BUFFER_DESC
		desc.ByteWidth = 128
		desc.Usage = D3D11_USAGE_DYNAMIC
		desc.BindFlags = D3D11_BIND_CONSTANT_BUFFER
		desc.cpuAccessFlags = D3D11_CPU_ACCESS_WRITE

		_pipeline._device.createBuffer(desc, Null, _vertexConstantBufferPerFrame)
		If Not _vertexConstantBufferPerFrame DebugLog " cannot create vertex per frame constant buffer"
		
		' per object
		desc.ByteWidth = 64
		_pipeline._device.createBuffer(desc, Null, _vertexConstantBufferPerObject)
		If Not _vertexConstantBufferPerObject DebugLog " cannot create vertex per object constant buffer"
		
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

	Method CreateShaderSourceByteCode:ID3DBlob(source:String, func:String, profile:String)
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
		
		source :+ "float4 PSMain(PSINPUT psIn) : SV_Target{~n"
		source :+ "    return float4(1.0, 1.0, 1.0, 1.0);~n"
		source :+ "};~n"

		Return source
	EndMethod
	
	Method run()
		Local view:Float[] = [1.0, 0.0, 0.0, 0.0,..
							  0.0, 1.0, 0.0, 0.0,..
							  0.0, 0.0, 1.0, 25.0,..
							  0.0, 0.0, 0.0, 1.0]

		Local model:Float[] = [1.0, 0.0, 0.0, 0.0,..
							  0.0, 1.0, 0.0, 0.0,..
							  0.0, 0.0, 1.0, 0.0,..
							  0.0, 0.0, 0.0, 1.0]
							
		_pipeline.setWireframeOn()
		_pipeline._context.IASetInputLayout(_inputLayout)

		set3DProjection(60.0, 1200.0 / 700.0, 0.1, 1000.0)
		'set2DProjection(800, 600)

		While Not AppTerminate()
			_pipeline.Cls([0.0, 0.0, 0.0, 1.0])
			
			' start frame
			_pipeline._context.VSSetConstantBuffers(0, 1, Varptr _vertexConstantBufferPerFrame)
			_pipeline._context.VSSetShader(_vertexShader, Null, 0)
			_pipeline._context.PSSetShader(_pixelShader, Null, 0)
			
			' per frame
			Local map:D3D11_MAPPED_SUBRESOURCE = New D3D11_MAPPED_SUBRESOURCE
			_pipeline._context.Map(_vertexConstantBufferPerFrame, 0, D3D11_MAP_WRITE_DISCARD, 0, map)
			MemCopy(map.pData, view, 64)
			MemCopy(map.pData + 64, _proj, 64)
			_pipeline._context.Unmap(_vertexConstantBufferPerFrame, 0)

			' per object
			_pipeline._context.Map(_vertexConstantBufferPerObject, 0, D3D11_MAP_WRITE_DISCARD, 0, map)
			MemCopy(map.pData, model, 64)
			_pipeline._context.Unmap(_vertexConstantBufferPerObject, 0)

			Local strides:Int = 12
			Local offsets:Int = 0
			_pipeline._context.IASetVertexBuffers(0, 1, Varptr _vertexBuffer, Varptr strides, Varptr offsets)
			_pipeline._context.IASetIndexBuffer(_indexBuffer, DXGI_FORMAT_R32_UINT, 0)
			_pipeline._context.VSSetConstantBuffers(1, 1, Varptr _vertexConstantBufferPerObject)
			
			_pipeline._context.DrawIndexed(6, 0, 0)
			
			_pipeline.Present(True)
		Wend
	EndMethod
	
	Method shutdown()
	EndMethod
EndType

Local game:tGame = New tGame
game.init(1200, 700)
game.run()
game.shutdown()














