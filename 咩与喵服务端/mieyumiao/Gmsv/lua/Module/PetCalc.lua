function PetPlus_ShowCalc(_PlayerIndex)
		local buf =  "\n �������������������������㵵��\n\n";
		buf = buf .. "���������ơ���������������ǿ�ȡ����ݡ�ħ������"
		for i = 0, 4 do
			local PetIndex = Char.GetPet(_PlayerIndex, i)
			if(PetIndex >=0) then
				--local buf1 = Char.GetData(PetIndex, %����_ԭ��%) .. "(" .. Char.GetPetEnemyId(_PlayerIndex, i) .. ")"
				local buf1 = Char.GetData(PetIndex, %����_����%)
				local buf2 = Pet.GetArtRank(PetIndex, %�赵_���%) .. "/" .. Pet.FullArtRank(PetIndex, %�赵_���%)
				local buf3 = Pet.GetArtRank(PetIndex, %�赵_����%) .. "/" .. Pet.FullArtRank(PetIndex, %�赵_����%)
				local buf4 = Pet.GetArtRank(PetIndex, %�赵_ǿ��%) .. "/" .. Pet.FullArtRank(PetIndex, %�赵_ǿ��%)
				local buf5 = Pet.GetArtRank(PetIndex, %�赵_����%) .. "/" .. Pet.FullArtRank(PetIndex, %�赵_����%)
				local buf6 = Pet.GetArtRank(PetIndex, %�赵_ħ��%) .. "/" .. Pet.FullArtRank(PetIndex, %�赵_ħ��%)
				local buf7 = Pet.GetArtRank(PetIndex, %�赵_���%) + Pet.GetArtRank(PetIndex, %�赵_����%) + Pet.GetArtRank(PetIndex, %�赵_ǿ��%) + Pet.GetArtRank(PetIndex, %�赵_����%) + Pet.GetArtRank(PetIndex, %�赵_ħ��%) - Pet.FullArtRank(PetIndex, %�赵_���%) - Pet.FullArtRank(PetIndex, %�赵_����%) - Pet.FullArtRank(PetIndex, %�赵_ǿ��%) - Pet.FullArtRank(PetIndex, %�赵_����%) - Pet.FullArtRank(PetIndex, %�赵_ħ��%)
				buf = buf .. string.format("%12.12s",buf1) .. string.format("%6.6s",buf2) .. string.format("%6.6s",buf3) .. string.format("%6.6s",buf4) .. string.format("%6.6s",buf5) .. string.format("%6.6s",buf6) .. string.format("%4.3s",buf7)
			else
				buf = buf .. string.format("%12.12s","�޳���") .. "\n"
			end
		end
		NLG.ShowWindowTalked(_PlayerIndex, CastleAttackNPC, 0, 1, 901, buf);
	return buf
end