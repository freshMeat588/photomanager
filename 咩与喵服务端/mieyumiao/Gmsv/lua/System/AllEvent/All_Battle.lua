--ս����ʼȫ���¼�
function All_BattleStartEvent(_battleIndex)
	-- BattleStart delegate begin
	for _,Func in ipairs(tbl_delegate_BattleStartEvent) do
    local f = loadstring(Func.."(".._battleIndex..")");	
	f();
    end
	-- end
	return;
end


 --ս������ȫ���¼�
function All_BattleOverEvent(_battleIndex)
	-- BattleOver delegate begin
	for _,Func in ipairs(tbl_delegate_BattleOverEvent) do
    local f = loadstring(Func.."(".._battleIndex..")");	
	f();
    end
	-- end
	return;
end

 --ս���˳�ȫ���¼�
function All_BattleExitEvent(_chrPtr, _battleIndex, _flg)
	-- BattleExit delegate begin
	for _,Func in ipairs(tbl_delegate_BattleExitEvent) do
    local f = loadstring(Func.."(".._battleIndex..")");	
	f();
    end
	-- end
	return;
end

