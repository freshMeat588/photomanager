dofile("lua/System/BaseModule/Delegate.lua");
dofile("lua/System/OtherModule/EasyLuaFunc.lua");
--dofile("lua/System/ObjectModule/objNPC.lua");
require("lua/System/BaseModule/Base");
require("lua/System/AllEvent/All_Talk");
require("lua/System/AllEvent/All_Battle");
require("lua/System/AllEvent/All_Login");
require("lua/System/AllEvent/All_Warp");
require("lua/System/AllEvent/All_Player");
require("lua/System/AllEvent/All_System");

function initALL()
	
	
	--ע��ȫ���¼�
	NL.RegTalkEvent(nil,"All_TalkEvent");
	NL.RegBattleStartEvent(nil,"All_BattleStartEvent");
	NL.RegBattleOverEvent(nil,"All_BattleOverEvent");
	NL.RegLoginEvent(nil,"All_LoginEvent");
	NL.RegLogoutEvent(nil,"All_LogoutEvent");
	NL.RegDropEvent(nil,"All_DropEvent");
	NL.RegLoginGateEvent(nil,"All_LoginGateEvent");
	NL.RegWarpEvent(nil,"All_WarpEvent");

	dofile("lua/Config.lua");
	-- Init delegate begin
    for _,Func in ipairs(tbl_delegate_Init) do
    local f = loadstring(Func.."()");	
	f();
    end
    -- end
	
 end
initALL();



