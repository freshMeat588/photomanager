--  ***************************************************************************************************** --
--  code by http://www.Cgdev.me
--  适用版本 GMSV Avaritia 所有版本,GMSVPLUS 所有版本
--              #UPDATE LIST#
--  TYPE ***** TIME ***** Editor ***** Text 
--  CREATE  2013/01/15     blue
--  ADD     2013/01/15     blue        增加以下委托调用
--										*RegInit 					--全局初始化事件
--   								   	*RegDelTalkEvent 			--全局对话事件
--   								   	*RegDelBattleStartEvent		--全局战斗开始事件
--   								   	*RegDelBattleOverEvent		--全局战斗结束事件
--   								   	*RegDelLoginEvent			--全局登入事件
--   								   	*RegDelLogoutEvent			--全局登出事件
--   								   	*RegDelDropEvent			--全局掉线事件
--   								   	*RegDelLoginGateEvent		--全局登回城事件
--   								   	*RegDelWarpEvent			--全局传送事件
--   								   	*RegDelAllOutEvent 			--全局离开事件  /* 注：此委托之前也会调用DropEvent或LogoutEvent */
--  ADD     2013/04/27     ducky       增加以下委托调用
--										*RegDelBattleExitEvent		--全局战斗离开事件
--   								   	*RegDelRightClickEvent 		--全局鼠标右击玩家事件
--   								   	*RegDelGatherTechUsedEvent	--全局使用采集技能事件
--   								   	*RegDelGetExpEvent			--全局获得战斗经验事件
--   								   	*RegDelLevelUpEvent			--全局玩家升级事件
--   								   	*RegDelRankUpEvent			--全局玩家晋级事件
--  ADD     2013/05/31     ducky       增加以下委托调用
--   								   	*RegDelShutDownEvent		--全局服务器关闭事件
--   								   	*RegDelItemString			--全局物品标签事件


--  ***************************************************************************************************** --

tbl_delegate_Init = {};
tbl_delegate_TalkEvent = {};
tbl_delegate_BattleStartEvent = {};
tbl_delegate_BattleOverEvent = {};
tbl_delegate_LoginEvent = {};
tbl_delegate_LogoutEvent = {};
tbl_delegate_DropEvent = {};
tbl_delegate_LoginGateEvent = {};
tbl_delegate_WarpEvent = {};
tbl_delegate_AllOutEvent = {};
tbl_delegate_BattleExitEvent = {};
tbl_delegate_RightClickEvent = {};
tbl_delegate_GatherTechUsedEvent = {};
tbl_delegate_GetExpEvent = {};
tbl_delegate_LevelUpEvent = {};
tbl_delegate_RankUpEvent = {};
tbl_delegate_ShutDownEvent = {};
tbl_delegate_ItemString = {};


Delegate =
{
	RegInit = function(FuncString) RegInit(FuncString) end;
    RegDelTalkEvent = function(FuncString) RegDelTalkEvent(FuncString) end;
    RegDelRightClickEvent = function(FuncString) RegDelRightClickEvent(FuncString) end;
	RegDelBattleStartEvent = function(FuncString) RegDelBattleStartEvent(FuncString) end;
	RegDelBattleOverEvent = function(FuncString) RegDelBattleOverEvent(FuncString) end;
	RegDelBattleExitEvent = function(FuncString) RegDelBattleExitEvent(FuncString) end;
	RegDelLoginEvent = function(FuncString) RegDelLoginEvent(FuncString) end;
	RegDelLogoutEvent = function(FuncString) RegDelLogoutEvent(FuncString) end;
	RegDelDropEvent = function(FuncString) RegDelDropEvent(FuncString) end;
	RegDelLoginGateEvent = function(FuncString) RegDelLoginGateEvent(FuncString) end;
	RegDelWarpEvent = function(FuncString) RegDelWarpEvent(FuncString) end;
	RegDelAllOutEvent = function(FuncString) RegDelAllOutEvent(FuncString) end;
	RegDelGatherTechUsedEvent = function(FuncString) RegDelGatherTechUsedEvent(FuncString) end;
	RegDelGetExpEvent = function(FuncString) RegDelGetExpEvent(FuncString) end;
	RegDelLevelUpEvent = function(FuncString) RegDelLevelUpEvent(FuncString) end;
	RegDelRankUpEvent = function(FuncString) RegDelRankUpEvent(FuncString) end;
	RegDelShutDownEvent = function(FuncString) RegDelShutDownEvent(FuncString) end;
	RegDelItemString = function(FuncString) RegDelItemString(FuncString) end;

};

--注册初始化事件委托
function RegInit(FuncString)
	
   for _,v in ipairs(tbl_delegate_Init) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_Init,FuncString);
   return true;
end


--注册全局对话事件委托
function RegDelTalkEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_TalkEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_TalkEvent,FuncString);
   return true;
end


--注册全局战斗开始事件委托
function RegDelBattleStartEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_BattleStartEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_BattleStartEvent,FuncString);
   return true;
end

--注册全局战斗结束事件委托
function RegDelBattleOverEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_BattleOverEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_BattleOverEvent,FuncString);
   return true;
end

--注册全局登录事件委托
function RegDelLoginEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_LoginEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_LoginEvent,FuncString);
   return true;
end

--注册全局登出事件委托
function RegDelLogoutEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_LogoutEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_LogoutEvent,FuncString);
   return true;
end

--注册全局掉线事件委托
function RegDelDropEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_DropEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_DropEvent,FuncString);
   return true;
end


--注册全局登回城事件委托
function RegDelLoginGateEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_LoginGateEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_LoginGateEvent,FuncString);
   return true;
end

--注册全局传送事件委托
function RegDelWarpEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_WarpEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_WarpEvent,FuncString);
   return true;
end

--注册全局离开事件委托（包括登出和掉线）
function RegDelAllOutEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_AllOutEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_AllOutEvent,FuncString);
   return true;
end

--注册全局战斗退出事件委托
function RegDelBattleExitEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_BattleExitEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_BattleExitEvent,FuncString);
   return true;
end

--注册全局鼠标右击玩家事件委托
function RegDelRightClickEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_RightClickEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_RightClickEvent,FuncString);
   return true;
end

--注册全局使用采集技能事件委托
function RegDelGatherTechUsedEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_GatherTechUsedEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_GatherTechUsedEvent,FuncString);
   return true;
end

--注册全局获得战斗经验事件委托
function RegDelGetExpEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_GetExpEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_GetExpEvent,FuncString);
   return true;
end

--注册全局玩家升级事件委托
function RegDelLevelUpEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_LevelUpEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_LevelUpEvent,FuncString);
   return true;
end

--注册全局玩家晋级事件委托
function RegDelRankUpEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_RankUpEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_RankUpEvent,FuncString);
   return true;
end

--注册全局服务器关闭委托
function RegDelShutDownEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_ShutDownEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_ShutDownEvent,FuncString);
   return true;
end

--注册全局物品标签委托
function RegDelItemString(FuncString)
	
   for _,v in ipairs(tbl_delegate_ItemString) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_ItemString,FuncString);
   return true;
end
