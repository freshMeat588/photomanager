function All_WarpEvent(player,x,y)

	for _,Func in ipairs(tbl_delegate_WarpEvent) do
	--print("/n ALL :"..Func.."("..player..")");
	if(player == nil)then
		NLG.SystemMessage(player,Func.."(nil)");
		return;
	end
	--NLG.SystemMessage(player,Func.."("..player..")");
    local f = loadstring(Func.."("..player..")");	
	
	f();
    end
	return;
end