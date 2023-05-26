local Const = {}

local function getConst(ver)
	if ver=="ga" then
		Const = {
				Image = 2,
				Picture = 3,
				Map = 4,
				Floor = 5,
				X = 6,
				Y = 7,
				Dir = 8,
				Name = 2000
				}
	end
	return true
end


-----------------
--Property Start
-----------------
local function Npc_Prop_Index(self, Value)
	if Value==nil or Value=="" then
		return self.Prop.Index
	else
		print("Lua_Error_objNPC: Index�����޷��޸�")
		return false
	end
end

local function Npc_Prop_Image(self, Value)
	if Value==nil or Value=="" then
		self.Prop.Image = self:Get(Const.Image)
		return self.Prop.Image
	elseif type(Value)=="number" then
		self:Set(Const.Image, Value)
		self.Prop.Image = self:Get(Const.Image)
		return true
	else
		print("Lua_Error_objNPC: Image����ֻ��д�����֣��磺1008611��")
		return false
	end
end

local function Npc_Prop_Picture(self, Value)
	if Value==nil or Value=="" then
		self.Prop.Picture = self:Get(Const.Picture)
		return self.Prop.Picture
	elseif type(Value)=="number" then
		self:Set(Const.Picture, Value)
		self.Prop.Picture = self:Get(Const.Picture)
		return true
	else
		print("Lua_Error_objNPC: Picture����ֻ��д�����֣��磺1008611��")
		return false
	end
end

local function Npc_Prop_MapPos(self, Value)
	if Value==nil or Value=="" then
		self.Prop.MapPos = Char.GetData(self.Prop.Index, Const.Map) .. "," .. Char.GetData(self.Prop.Index, Const.Floor) .. "," .. Char.GetData(self.Prop.Index,Const.X) .. "," .. Char.GetData(self.Prop.Index, Const.Y)
		return self.Prop.MapPos
	elseif type(Value)=="string" and Split(Value, ",")[4]~=nil then
		local tMapPos = Split(Value, ",");
		self:Set(Const.Map, tMapPos[1]);
		self:Set(Const.Floor, tMapPos[2]);
		self:Set(Const.X, tMapPos[3]);
		self:Set(Const.Y, tMapPos[4]);
		self.Prop.MapPos = self:Get(Const.MapPos)
		return true
	else
		print("Lua_Error_objNPC: MapPos����ֻ��д����Ӣ�Ķ��ŷָ���ɵ�4�����֣��磺0,1000,242,88��")
		return false
	end
end

local function Npc_Prop_Dir(self, Value)
	if Value==nil or Value=="" then
		self.Prop.Dir = self:Get(Const.Dir)
		return self.Prop.Dir
	elseif type(Value)=="number" and Value>=0 and Value<=7 then
		self:Set(Const.Dir, Value)
		self.Prop.Dir = self:Get(Const.Dir)
		return true
	else
		print("Lua_Error_objNPC: Dir����ֻ��д��0~7�����֣��磺4��")
		return false
	end
end

local function Npc_Prop_Name(self, Value)
	if Value==nil or Value=="" then
		self.Prop.Name = self:Get(Const.Name)
		return self.Prop.Name
	elseif type(Value)=="string" then
		self:Set(Const.Name, Value)
		self.Prop.Name = self:Get(Const.Name)
		return true
	else
		print("Lua_Error_objNPC: Name���Բ��ð��������ַ���/' /; /: /. /, /` /~ /*")
		return false
	end
end

local function Npc_Prop_Model(self, Value)
	if Value==nil or Value=="" then
		return self.Prop.Model
	else
		print("Lua_Error_objNPC: Model�����޷��޸�")
		return false
	end
end

local function chkChangeName(Value)

	return true
end
-----------------
--Property End
-----------------



---------------
--Method Start
---------------
local function Npc_New(self, o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

local function Npc_LoadModel(self, fileModel)
	if self:isActive()==true then
		print("Lua_Error_objNPC: Object�����Ѽ���޷�LoadModel����NPCģ��")
		return false
	end
end

function initCreateNpc_Init(index)
	--print("objNPC_index = " .. index);
	return true;
end

local function Npc_Create(self)
	local newNPC = NL.CreateNpc(nil, "initCreateNpc_Init");
	self.Prop.Index = newNPC
	self:Update()
	return true
end

local function Npc_Update(self)
	if self:isActive()==false then
		print("Lua_Error_objNPC: Object����δ�������޷�Update����")
		return false
	end
	local tMapPos = Split(self.Prop.MapPos, ",");
	Char.SetData(self.Prop.Index, Const.Image, self.Prop.Image);
	Char.SetData(self.Prop.Index, Const.Picture, self.Prop.Picture);
	Char.SetData(self.Prop.Index, Const.Map, tMapPos[1]);
	Char.SetData(self.Prop.Index, Const.Floor, tMapPos[2]);
	Char.SetData(self.Prop.Index, Const.X, tMapPos[3]);
	Char.SetData(self.Prop.Index, Const.Y, tMapPos[4]);
	Char.SetData(self.Prop.Index, Const.Dir, self.Prop.Dir);
	Char.SetData(self.Prop.Index, Const.Name, self.Prop.Name);
	NLG.UpChar(self.Prop.Index)
	return true
end

local function Npc_Del(self)
	if self:isActive()==false then
		print("Lua_Error_objNPC: Object����δ�������޷�Delɾ��")
		return false
	end
	NL.DelNpc(self.Prop.Index)
	self = nil
	return true
end

local function Npc_GetData(self, Const)
	if self:isActive()==false then
		print("Lua_Error_objNPC: Object����δ�������޷�GetData��ȡ����")
		return false
	end		
	return Char.GetData(self.Prop.Index, Const)
end

local function Npc_SetData(self, Const, Value)
	if self:isActive()==false then
		print("Lua_Error_objNPC: Object����δ�������޷�SetData��������")
		return false
	end
	return Char.SetData(self.Prop.Index, Const, Value)
end

local function getProperty(self)
	if self:isActive()==false then
		print("Lua_Error_objNPC: Object����δ�������޷�getProperty��ȡ��������")
		return false
	end				
	self.Prop.Image = Char.GetData(self.Prop.Index, Const.Image);
	self.Prop.Picture = Char.GetData(self.Prop.Index, Const.Picture);
	self.Prop.MapPos = Char.GetData(self.Prop.Index, Const.Map) .. "," .. Char.GetData(self.Prop.Index, Const.Floor) .. "," .. Char.GetData(self.Prop.Index,Const.X) .. "," .. Char.GetData(self.Prop.Index, Const.Y)
	self.Prop.Dir = Char.GetData(self.Prop.Index, Const.Dir);
	self.Prop.Name = Char.GetData(self.Prop.Index, Const.Name);
	return true
end

local function isActive(self)
	if type(self)~="table" or self.Prop.Index==nil or self.Prop.Index==0 then
		return false
	end
	return true
end

function Npc_Walk(self, Dir, Count)
	NLG.WalkMove(self.Prop.Index, Dir)
	return true
end

local function Npc_getDistance(self, intPosX, intPosY)
	local mePosX = self:Get(Const.X)
	local mePosY = self:Get(Const.Y)
	return  math.abs(math.floor(math.sqrt((mePosX-intPosX)*(mePosX-intPosX)+(mePosY-intPosY)*(mePosY-intPosY))))
end

local function Npc_Navigation(self, intPosX, intPosY)
	local mePosX = self:Get(Const.X)
	local mePosY = self:Get(Const.Y)
	local TM_Dir = 0
	if (mePosX==intPosX and mePosY>intPosY) then
		TM_Dir = 0;
	elseif (mePosX<intPosX and mePosY>intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))>2) then
		TM_Dir = 2;
	elseif (mePosX<intPosX and mePosY>intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))<-2) then
		TM_Dir = 0;
	elseif (mePosX<intPosX and mePosY>intPosY) then
		TM_Dir = 1;
	elseif (mePosX<intPosX and mePosY==intPosY) then
		TM_Dir = 2;
	elseif (mePosX<intPosX and mePosY<intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))>2) then
		TM_Dir = 2;
	elseif (mePosX<intPosX and mePosY<intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))<-2) then
		TM_Dir = 4;
	elseif (mePosX<intPosX and mePosY<intPosY) then
		TM_Dir = 3;
	elseif (mePosX==intPosX and mePosY<intPosY) then
		TM_Dir = 4;
	elseif (mePosX>intPosX and mePosY<intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))>2) then
		TM_Dir = 4;
	elseif (mePosX>intPosX and mePosY<intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))<-2) then
		TM_Dir = 6;
	elseif (mePosX>intPosX and mePosY<intPosY) then
		TM_Dir = 5;
	elseif (mePosX>intPosX and mePosY==intPosY) then
		TM_Dir = 6;
	elseif (mePosX>intPosX and mePosY>intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))>2) then
		TM_Dir = 6;
	elseif (mePosX>intPosX and mePosY>intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))<-2) then
		TM_Dir = 0
	elseif (mePosX>intPosX and mePosY>intPosY) then
		TM_Dir = 7;
	elseif (mePosX==intPosX and mePosY==intPosY) then
		TM_Dir = -1;
	end
	
	return true
end
---------------
--Method End
---------------



---------------
--Event Start
---------------
local function Npc_SetWalkOver_Event(self, FuncName)
	if isActive(self)==false then
		--error("object is nil")
		print("Lua_Error_objNPC: Object����δ�������޷�����Event�¼�")
		return false
	end
	Char.SetWalkOverEvent(nil,FuncName,self.Prop.Index)
end

local function Npc_SetWalkPost_Event(self, FuncName)
	if isActive(self)==false then
		--error("object is nil")
		print("Lua_Error_objNPC: Object����δ�������޷�����Event�¼�")
		return false
	end		
	Char.SetWalkPostEvent(nil,FuncName,self.Prop.Index)
end

local function Npc_SetWalkPre_Event(self, FuncName)
	if isActive(self)==false then
		--error("object is nil")
		print("Lua_Error_objNPC: Object����δ�������޷�����Event�¼�")
		return false
	end		
	Char.SetWalkPreEvent(nil,FuncName,self.Prop.Index)
end

local function Npc_SetTalked_Event(self, FuncName)
	if isActive(self)==false then
		--error("object is nil")
		print("Lua_Error_objNPC: Object����δ�������޷�����Event�¼�")
		return false
	end
	Char.SetTalkedEvent(nil,FuncName,self.Prop.Index)
end

local function Npc_SetWindowTalked_Event(self, FuncName)
	if isActive(self)==false then
		--error("object is nil")
		print("Lua_Error_objNPC: Object����δ�������޷�����Event�¼�")
		return false
	end		
	Char.SetWindowTalkedEvent(nil,FuncName,self.Prop.Index)
end

local function Npc_SetLoop_Event(self, FuncName, LoopTime)
	if isActive(self)==false then
		--error("object is nil")
		print("Lua_Error_objNPC: Object����δ�������޷�����Event�¼�")
		return false
	end
	if LoopTime==nil or LoopTime==0 then LoopTime=1000 end
	Char.SetLoopEvent(nil,FuncName,self.Prop.Index,LoopTime)
end
---------------
--Event End
---------------

---------------
--Object Start
---------------
objNPC = {
		--Property���Դ洢
		Prop={
			Index = 0,
			Image = 231088,
			Picture = 231088,
			MapPos = "0,1000,242,86",
			Dir = 1,
			Name = "�ҽ�MT",
			Model = ""
			},
		--Property���Զ�д
		Index = Npc_Prop_Index,
		Image = Npc_Prop_Image,
		Picture = Npc_Prop_Picture,
		MapPos = Npc_Prop_MapPos,
		Dir = Npc_Prop_Dir,
		Name = Npc_Prop_Name,
		--Method����
		New = Npc_New,			--����NPCģ��
		Load = Npc_LoadModel,	--����NPCģ��
		Create = Npc_Create,	--����NPC
		Update = Npc_Update,	--����NPC
		Get = Npc_GetData,		--GetData
		Set = Npc_SetData,		--SetData
		Del = Npc_Del,			--ɾ��NPC
		Walk = Npc_Walk,		--��NPC��ĳ�������ƶ�
		WalkToPos = Npc_WalkToPos,	--��NPC�ƶ���ָ������
		Warp = Npc_Warp,		--����NPC
		getDistance = Npc_getDistance	--��ȡĿ���������
		--BaseFunction
		isActive = isActive,
		--Event�¼�
		WalkOver = Npc_SetWalkOver_Event,
		WalkPost = Npc_SetWalkPost_Event,
		WalkPre = Npc_SetWalkPre_Event,
		Talked = Npc_SetTalked_Event,
		Loop = Npc_SetLoop_Event,
		WindowTalked = Npc_SetWindowTalked_Event,
		--End
		End
		}
---------------
--Object End
---------------

getConst("ga")