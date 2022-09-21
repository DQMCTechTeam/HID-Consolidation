USE HID
select * from [HID] h where substring(h.QuestionNum,1,1)='e' order by h.DMISID, h.QuestionNum