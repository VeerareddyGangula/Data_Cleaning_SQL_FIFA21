--ID
--ID column is default Cleaned

-- Droping Unwanted Columns
--Name
alter table fifa_data1
drop column Name

--LongName
alter table fifa_data1
drop column LongName

--photoUrl
alter table fifa_data1
drop column photoUrl

--playerUrl
alter table fifa_data1
drop column playerUrl


-- Player_Full_Name
--creating a new column player name
alter table fifa_data1
add Player_Full_Name varchar(100)


--populate it with player names in the url
update  fifa_data1
set Player_Full_Name = SUBSTRING(playerUrl, 33, LEN(Longname)+2)


--remove the unwanted part of the names such as -, / and the likes
update fifa_data1
set Player_Full_Name = REPLACE(UPPER(
								CASE WHEN CHARINDEX('/',Player_Full_Name) > 0
									 THEN SUBSTRING(Player_Full_Name,1,CHARINDEX('/',Player_Full_Name)-1)
									 ELSE Player_Full_Name
								END
							),'-',' ')

--Age
--Age column is default Cleaned


--Nationality
--Nationality column is default Cleaned

-------------------------------------------------------------------------------
--Club Column
-- checking and removig anu unwanted characters such as 1 and . in club column
Update fifa_data1
set Club = Replace(Replace(Club,'.',''),'1','')

-- removing spaces in club column
select club,
substring(club,1,4) as space,
SUBSTRING(club,5,len(club)) as clubname from fifa_data1

update fifa_data1
set club = substring(club,5,len(club))
where club <> 'NO CLUB'

--------------------------------------------------------------------------------

--Positions
Update fifa_data1
set Positions = Replace(Positions,',','\')

-----------------------------------------------------------------------------------------------------

--Height

-- replace ' with . and " with space
update fifa_data1
set Height = replace(replace(Height,'''','.'),'"','')
where Height not like '%cm'

-- created new table from fifa_data1 table with ID,Height,Feets,Inches columns
select ID,Height,
Substring(Height,1,charindex('.',Height)-1) as Feets,
Substring(Height,charindex('.',Height)+1,charindex('.',Height)+2) as Inches
into Height_cm
from fifa_data1 where Height not like '%cm'

--changing datatype from nvarchar to int
alter table Height_cm
alter column Feets int

--changing datatype from nvarchar to int
alter table Height_cm
alter column Inches int

--adding column Height_in_cm
alter table Height_in_cm
add  Height_cm int

-- multiply Feets and Inches to convert into cm
update Height_cm
set Height_in_cm = round((Feets * 30.48) + (Inches * 2.54),0)

--Join Height_in_cm Column from Height_cm table  with fifa_data1 Height column 
update fifa_data1
set fifa_data1.Height = Height_cm.Height_in_cm
from fifa_data1
join Height_cm
on fifa_data1.ID = Height_cm.ID
where fifa_data1.Height not like '%cm'

update fifa_data1
set Height = replace(Height,'cm','')


------------------------------------------------------------------------------------------------------
-- Weight

-- create new table with ID,Weight that lbs as extension
select ID,Weight into fifa_weight
from fifa_data1 where Weight like '%lbs'

--replace lbs with ''
update fifa_weight
set Weight = replace(Weight,'lbs','') where Weight like '%lbs'

--change datatype to int
alter table fifa_weight
alter column Weight int

-- multiply with 0.454
update fifa_weight
set Weight = round(Weight * 0.454,0)


-- join fifa_weight with fifa_data where lbs with kg
update fifa_data1
set	fifa_data1.Weight = fifa_weight.Weight
from fifa_data1 
inner join fifa_weight
on fifa_data1.ID = fifa_weight.ID
where fifa_data1.Weight like '%lbs'

update fifa_data1
set Weight = replace(Weight,'kg','')
----------------------------------------------------------------------------
-- Preferred_Foot
-- Column does'nt have duplicates and correct datatype (defaultly cleaned)
----------------------------------------------------------------------------
-- Best_Position
-- Column does'nt have duplicates and correct datatype (defaultly cleaned)
----------------------------------------------------------------------------
-- Joined
-- Column does'nt have duplicates and correct datatype (defaultly cleaned)
----------------------------------------------------------------------------
-- Attacking,
--Crossing,
--Finishing,
--Heading_Accuracy,
--Short_Passing,
--Volleys,
--skill,
--Dribbling,
--Curve,
--FK_Accuracy,
--Long_Passing,
--Ball_Control,
--Movement,
--Acceralation,
--Sprint_Speed,
--Agility,
--Reactions,
--Balance,
--Power,
--Shot_Power,
--Jumping,
--Stamina,
--Strengths,
--Long_Shots,
--Mentality,
--Aggression,
--Interceptions,
--Positioning,
--Vision,
--Penalties,
--Composure,
--Defending,
--Marking,
--Standing_Tackle,
--Sliding_Tackle,
--GoalKeeping,
--GK_Diving,
--GK_Handling,
--GK_Kicking,
--GK_Positioning,
--GK_Refleaxes,
--Total_Stats,
--Base_Stats,
--PAC,
--SHO,
--PAS,
--DRI,
--DEF,
--PHY

-- Columns does'nt have duplicates and correct datatype (defaultly cleaned)
----------------------------------------------------------------------------
--W/F 

-- replacing ★ with ''
update fifa_data1
set W_F = replace(W_F,N'★','') 

-----------------------------------------------------------------------------

-- SM
-- replacing ★ with ''
update fifa_data1
set SM = replace(SM,N'★','') 


-----------------------------------------------------------------------------
-- IR

-- replacing ★ with ''
update fifa_data1
set IR = replace(IR,N'★','') 

------------------------------------------------------------------------------
--wage


update fifa_data1
set wage = case

		when wage like '€%' and wage like '%M' then try_convert(decimal(10,2),
replace(replace(wage,'€',''),'M',''))* 1000000
		when wage like '€%' and wage like '%K' then try_convert(decimal(10,2),
replace(replace(wage,'€',''),'K',''))*1000
		when wage like '€%' then try_convert(decimal(10,2),replace(wage,'€',''))
		else wage
end

--------------------------------------------------------------------------------------

-- value


update fifa_data1
set value = case

		when value like '€%' and value like '%M' then try_convert(decimal(10,2),
replace(replace(value,'€',''),'M',''))* 1000000
		when value like '€%' and value like '%K' then try_convert(decimal(10,2),
replace(replace(value,'€',''),'K',''))*1000
		when value like '€%' then try_convert(decimal(10,2),replace(value,'€',''))
		else value
end

----------------------------------------------------------------------------------------

-- release_clause


update fifa_data1
set release_clause = case

		when release_clause like '€%' and release_clause like '%M' then try_convert(decimal(10,2),
replace(replace(release_clause,'€',''),'M',''))* 1000000
		when release_clause like '€%' and release_clause like '%K' then try_convert(decimal(10,2),
replace(replace(release_clause,'€',''),'K',''))*1000
		when release_clause like '€%' then try_convert(decimal(10,2),replace(release_clause,'€',''))
		else release_clause
end


---------------------------------------------------------------------

--Hits

update fifa_data1
set hits = 
case 
	when upper(hits) like '%K' then try_convert(decimal(10,2),substring(hits,1,len(hits)-1)) * 1000
	else try_convert(decimal(10,2),hits)
end

-----------------------------------------------------------------------
-- contract

--updating contract column delimeter
update fifa_data1
set contract = replace(contract,'~','-')

--updating contract column dates written in text with "On Loan"
update fifa_data1
set Contract = 'On Loan'
where contract like '%On Loan%'

-- To Split the Contract Column
-- we have to create new columns Contract_Start_Year,Contract_End_Year
alter table fifa_data1
add  Contract_Start_Year Varchar(20),
     Contract_End_Year Varchar(20)

--populate new columns using the contract column
update fifa_data1
set Contract_Start_Year = case
							when contract like '%Loan%' then 'On Loan'
							when contract like '%Free%' then 'Free'
							else cast(year(cast(left(contract,4) as date))as varchar(20))
						  end,
    Contract_End_Year = case
							when contract like '%Loan%' then 'On Loan'
							when contract like '%Free%' then 'Free'
							else cast(year(cast(right(contract,4) as date))as varchar(20))
end
where Contract like '%-%' or Contract like '%loan%' or Contract like '%Free%'

-- adding new column contract status
alter table fifa_data1
add Contract_Status varchar(20)

-- updating contract status column using contract column
update fifa_data1
set Contract_Status = case 
						when contract like '%-%' then 'Active Contract'
						when Contract like '%loan%' then 'On Loan'
						when Contract like '%Free%' then 'Free'
						else null
					  end

-- update contract_end_year with years in loan_date_end for loan players
update fifa_data1
set contract_end_year = case
							when contract like '%on loan%' and Loan_Date_End is not null
							then convert(nvarchar,Loan_Date_End,23)
							else contract_end_year
						end
where contract like '%on loan%'

-- adding new column Loan_Status rather than Loan_Date_End
alter table fifa_data1 
add Loan_Status nvarchar(100)

-- updating loan status column using contract column
update fifa_data1
set Loan_Status = case
					when contract like '%loan%' then 'On Loan'
					when contract like '%Free%' then 'Free'
					else 'Not On Loan'
				  end
-------------------------------------------------------------------------

-- Changing Datatypes

alter table fifa_clean
alter column Height int

alter table fifa_clean
alter column Weight int

alter table fifa_clean
alter column wage money

alter table fifa_clean
alter column value money

alter table fifa_clean
alter column release_clause money

alter table fifa_clean
alter column W_F int

alter table fifa_clean
alter column SM int

alter table fifa_clean
alter column IR int

-- Renaming Column Names

sp_rename 'fifa_clean.Player_Full_Name','FullName'

sp_rename 'fifa_clean.IR','Injury_Resistance'

sp_rename 'fifa_clean.SM','Skill_Moves_Ability'

sp_rename 'fifa_clean.W_F','Weaker_Foot_Ability'

sp_rename 'fifa_clean.Weight','Weight(KG)'

sp_rename 'fifa_clean.Height','Height(CM)'

sp_rename 'fifa_clean.Wage','Wage(€)'

sp_rename 'fifa_clean.Value','Value(€)'

sp_rename 'fifa_clean.Release_Clause','Release_Clause(€)'

sp_rename 'fifa_clean.PAC','Pace'

sp_rename 'fifa_clean.SHO','Shooting_Attribute'

sp_rename 'fifa_clean.PAS','Pass_Accuracy'

sp_rename 'fifa_clean.D_W','Defensive_Work_Rate'

sp_rename 'fifa_clean.A_W','Attacking_Work_Rate'
