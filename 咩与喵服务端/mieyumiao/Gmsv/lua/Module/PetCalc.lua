function PetPlus_ShowCalc(_PlayerIndex)
		local buf =  "\n 　　　　　　　　　【宠物算档】\n\n";
		buf = buf .. "　　　名称　　体力　力量　强度　敏捷　魔法　档"
		for i = 0, 4 do
			local PetIndex = Char.GetPet(_PlayerIndex, i)
			if(PetIndex >=0) then
				--local buf1 = Char.GetData(PetIndex, %对象_原名%) .. "(" .. Char.GetPetEnemyId(_PlayerIndex, i) .. ")"
				local buf1 = Char.GetData(PetIndex, %对象_名字%)
				local buf2 = Pet.GetArtRank(PetIndex, %宠档_体成%) .. "/" .. Pet.FullArtRank(PetIndex, %宠档_体成%)
				local buf3 = Pet.GetArtRank(PetIndex, %宠档_力成%) .. "/" .. Pet.FullArtRank(PetIndex, %宠档_力成%)
				local buf4 = Pet.GetArtRank(PetIndex, %宠档_强成%) .. "/" .. Pet.FullArtRank(PetIndex, %宠档_强成%)
				local buf5 = Pet.GetArtRank(PetIndex, %宠档_敏成%) .. "/" .. Pet.FullArtRank(PetIndex, %宠档_敏成%)
				local buf6 = Pet.GetArtRank(PetIndex, %宠档_魔成%) .. "/" .. Pet.FullArtRank(PetIndex, %宠档_魔成%)
				local buf7 = Pet.GetArtRank(PetIndex, %宠档_体成%) + Pet.GetArtRank(PetIndex, %宠档_力成%) + Pet.GetArtRank(PetIndex, %宠档_强成%) + Pet.GetArtRank(PetIndex, %宠档_敏成%) + Pet.GetArtRank(PetIndex, %宠档_魔成%) - Pet.FullArtRank(PetIndex, %宠档_体成%) - Pet.FullArtRank(PetIndex, %宠档_力成%) - Pet.FullArtRank(PetIndex, %宠档_强成%) - Pet.FullArtRank(PetIndex, %宠档_敏成%) - Pet.FullArtRank(PetIndex, %宠档_魔成%)
				buf = buf .. string.format("%12.12s",buf1) .. string.format("%6.6s",buf2) .. string.format("%6.6s",buf3) .. string.format("%6.6s",buf4) .. string.format("%6.6s",buf5) .. string.format("%6.6s",buf6) .. string.format("%4.3s",buf7)
			else
				buf = buf .. string.format("%12.12s","无宠物") .. "\n"
			end
		end
		NLG.ShowWindowTalked(_PlayerIndex, CastleAttackNPC, 0, 1, 901, buf);
	return buf
end