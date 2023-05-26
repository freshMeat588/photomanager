--  ***************************************************************************************************** --
--  code by http://www.Cgdev.me
--  ���ð汾 GMSV Avaritia ���а汾,GMSVPLUS ���а汾
--              #UPDATE LIST#
--  TYPE ***** TIME ***** Editor ***** Text 
--  CREATE  2013/01/15     blue
--  ADD     2013/01/15     blue        ��������ί�е���
--										*RegInit 					--ȫ�ֳ�ʼ���¼�
--   								   	*RegDelTalkEvent 			--ȫ�ֶԻ��¼�
--   								   	*RegDelBattleStartEvent		--ȫ��ս����ʼ�¼�
--   								   	*RegDelBattleOverEvent		--ȫ��ս�������¼�
--   								   	*RegDelLoginEvent			--ȫ�ֵ����¼�
--   								   	*RegDelLogoutEvent			--ȫ�ֵǳ��¼�
--   								   	*RegDelDropEvent			--ȫ�ֵ����¼�
--   								   	*RegDelLoginGateEvent		--ȫ�ֵǻس��¼�
--   								   	*RegDelWarpEvent			--ȫ�ִ����¼�
--   								   	*RegDelAllOutEvent 			--ȫ���뿪�¼�  /* ע����ί��֮ǰҲ�����DropEvent��LogoutEvent */
--  ADD     2013/04/27     ducky       ��������ί�е���
--										*RegDelBattleExitEvent		--ȫ��ս���뿪�¼�
--   								   	*RegDelRightClickEvent 		--ȫ������һ�����¼�
--   								   	*RegDelGatherTechUsedEvent	--ȫ��ʹ�òɼ������¼�
--   								   	*RegDelGetExpEvent			--ȫ�ֻ��ս�������¼�
--   								   	*RegDelLevelUpEvent			--ȫ����������¼�
--   								   	*RegDelRankUpEvent			--ȫ����ҽ����¼�
--  ADD     2013/05/31     ducky       ��������ί�е���
--   								   	*RegDelShutDownEvent		--ȫ�ַ������ر��¼�
--   								   	*RegDelItemString			--ȫ����Ʒ��ǩ�¼�


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

--ע���ʼ���¼�ί��
function RegInit(FuncString)
	
   for _,v in ipairs(tbl_delegate_Init) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_Init,FuncString);
   return true;
end


--ע��ȫ�ֶԻ��¼�ί��
function RegDelTalkEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_TalkEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_TalkEvent,FuncString);
   return true;
end


--ע��ȫ��ս����ʼ�¼�ί��
function RegDelBattleStartEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_BattleStartEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_BattleStartEvent,FuncString);
   return true;
end

--ע��ȫ��ս�������¼�ί��
function RegDelBattleOverEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_BattleOverEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_BattleOverEvent,FuncString);
   return true;
end

--ע��ȫ�ֵ�¼�¼�ί��
function RegDelLoginEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_LoginEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_LoginEvent,FuncString);
   return true;
end

--ע��ȫ�ֵǳ��¼�ί��
function RegDelLogoutEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_LogoutEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_LogoutEvent,FuncString);
   return true;
end

--ע��ȫ�ֵ����¼�ί��
function RegDelDropEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_DropEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_DropEvent,FuncString);
   return true;
end


--ע��ȫ�ֵǻس��¼�ί��
function RegDelLoginGateEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_LoginGateEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_LoginGateEvent,FuncString);
   return true;
end

--ע��ȫ�ִ����¼�ί��
function RegDelWarpEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_WarpEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_WarpEvent,FuncString);
   return true;
end

--ע��ȫ���뿪�¼�ί�У������ǳ��͵��ߣ�
function RegDelAllOutEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_AllOutEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_AllOutEvent,FuncString);
   return true;
end

--ע��ȫ��ս���˳��¼�ί��
function RegDelBattleExitEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_BattleExitEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_BattleExitEvent,FuncString);
   return true;
end

--ע��ȫ������һ�����¼�ί��
function RegDelRightClickEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_RightClickEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_RightClickEvent,FuncString);
   return true;
end

--ע��ȫ��ʹ�òɼ������¼�ί��
function RegDelGatherTechUsedEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_GatherTechUsedEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_GatherTechUsedEvent,FuncString);
   return true;
end

--ע��ȫ�ֻ��ս�������¼�ί��
function RegDelGetExpEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_GetExpEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_GetExpEvent,FuncString);
   return true;
end

--ע��ȫ����������¼�ί��
function RegDelLevelUpEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_LevelUpEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_LevelUpEvent,FuncString);
   return true;
end

--ע��ȫ����ҽ����¼�ί��
function RegDelRankUpEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_RankUpEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_RankUpEvent,FuncString);
   return true;
end

--ע��ȫ�ַ������ر�ί��
function RegDelShutDownEvent(FuncString)
	
   for _,v in ipairs(tbl_delegate_ShutDownEvent) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_ShutDownEvent,FuncString);
   return true;
end

--ע��ȫ����Ʒ��ǩί��
function RegDelItemString(FuncString)
	
   for _,v in ipairs(tbl_delegate_ItemString) do
       if (v == FuncString)then
       return false;
	   end
   end
   
   table.insert(tbl_delegate_ItemString,FuncString);
   return true;
end
