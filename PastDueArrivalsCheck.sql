USE HID
select * from [HID] h where substring(h.QuestionNum,1,5)='B.8.B' order by h.DMISID, h.QuestionNum