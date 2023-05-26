Delegate.RegDelBattleStartEvent("OneLevelPet_BattleStart");

--战斗开始全局事件
function OneLevelPet_BattleStart(_battle)
	if (Battle.GetGainMode(_battle)==%战奖_普通% and Battle.GetType(_battle)==%战斗_普通%) then
		battleTimeDB[_battle+1] = os.time();
		for i=10,19 do
			local enemy = Battle.GetPlayer(_battle, i);
			if(enemy>0)then
				battleSeqDB[_battle+1] = battleSeqDB[_battle+1] .. Char.GetData(enemy, %对象_名字%) .. "|"
				if(isLevelOnePet(enemy)==true)then
					for l=0,4 do
						local player = Battle.GetPlayer(_battle,l);
						if(player~=0)then
							print("[★☆★一级宠物★☆★]发现一级宠物★ "..Char.GetData(enemy,%对象_名字%).." ★出现!")
							NLG.SystemMessage(player,"[★☆★一级宠物★☆★]发现一级宠物★ "..Char.GetData(enemy,%对象_名字%).." ★出现!");
						end
					end
				end
			else
				battleSeqDB[_battle+1] = battleSeqDB[_battle+1].."|";
			end
		end
	end

	return;
end