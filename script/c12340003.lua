---@diagnostic disable: undefined-global
--系统故障
function c12340003.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCountLimit(1,12340003)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c12340003.target1)
	e1:SetOperation(c12340003.operation1)
	c:RegisterEffect(e1)
end
function c12340003.filter1(c,e)
	return c:IsFaceup() and c:IsLevelBelow(6) and c:IsDestructable(e)
end
function c12340003.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return  c12340003.filter1(chkc,e) end
	if chk==0 then return Duel.IsExistingTarget(c12340003.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,12340003,0x1999,TYPES_TOKEN_MONSTER+TYPE_TUNER,0,0,4,RACE_CYBERSE,ATTRIBUTE_EARTH) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c12340003.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c12340003.operation1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e)
    and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
    and Duel.IsPlayerCanSpecialSummonMonster(tp,12340003,0x1999,TYPES_TOKEN_MONSTER+TYPE_TUNER,0,0,4,RACE_CYBERSE,ATTRIBUTE_EARTH)
	and Duel.Destroy(tc,REASON_EFFECT) > 0
	then
		local token=Duel.CreateToken(tp,12340006)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end

end
