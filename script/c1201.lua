---@diagnostic disable: undefined-global
--系统故障
function c1201.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c1201.target1)
	e1:SetOperation(c1201.operation1)
	c:RegisterEffect(e1)
end
function c1201.filter1(c,e)
	return c:IsFaceup() and (c:IsLevelAbove(4) or c:IsRankAbove(4) or c:IsLinkAbove(4)) and c:IsDestructable(e)
end
function c1201.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return c1201.filter1(chkc,e) end
	if chk==0 then return Duel.IsExistingTarget(c1201.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,3,nil,e)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c1201.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,3,3,nil,e)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,3,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,tp,0)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		Duel.SetChainLimit(aux.FALSE)
	end
end
function c1201.operation1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c1201.filter1,nil,e)
	if g:GetCount()>0
	and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.Destroy(g,REASON_EFFECT) > 0
	then
		local token=Duel.CreateToken(tp,10000000)
		Duel.SpecialSummon(token,0,tp,tp,true,false,POS_FACEUP)
		token:CompleteProcedure()
		local token=Duel.CreateToken(tp,10000010)
		Duel.SpecialSummon(token,0,tp,tp,true,false,POS_FACEUP)
		token:CompleteProcedure()
		local token=Duel.CreateToken(tp,10000020)
		Duel.SpecialSummon(token,0,tp,tp,true,false,POS_FACEUP)
		token:CompleteProcedure()
	end

end
