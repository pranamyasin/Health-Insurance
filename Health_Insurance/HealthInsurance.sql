create database claim;

use claim;

desc insurance;
# Since only one table no primary key is present 
# Fields include age, sex, bmi, children, smoker, region, charges

select * from insurance;

Select distinct(age)
from insurance
order by age;

-- Indiviuals claiming insurance ranges from 18 to 64 age group

select * from insurance;
select AVG(charges) as 'Avg_charges_by_age', age
from insurance
group by age 
order by Avg_charges_by_age desc;

-- Highest Avg charge is for age 64 followed by 61,60,63,43 while lowest is for 21 followed by 26,18,38

select AVG(charges) as 'Avg_charges_by_sex', sex
from insurance
group by sex
order by Avg_charges_by_sex desc;

-- Males have more avg charge for insurance than females

select AVG(charges) as 'Avg_charges_by_bmi', bmi
from insurance
group by bmi
order by Avg_charges_by_bmi desc;

-- Avg charges does not completely depend on bmi since highest charge is shown for 47.41 bmi followed by those ranging in 30's while the lowest charge is for 43.01

SELECT 
    CASE 
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal'
        WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,
    AVG(charges) AS avg_charges
FROM insurance
GROUP BY bmi_category;

-- Maxim avg charges are from Overweight followed by obese, normal and lastly underweight

select AVG(charges) as 'Avg_charges_by_children', children
from insurance
group by children
order by Avg_charges_by_children desc;

-- Highest avg charge for cliam is for those having 3 children, charges decreases as per the no of children. However for those having 4 children the avg charge is the median, this could be influence by other factors as well

select AVG(charges) as 'Avg_charges_by_region', region
from insurance
group by region
order by Avg_charges_by_region desc; 

-- Maximum Avg charge is in southeast followed by northeast, northwest and finally southwest

Select * from insurance 
where charges =( select max(charges) from insurance);

-- Highest charge of about 63770.42801 has been deducted from a 54 yr Smoker Female with BMI of 47.41 and no children

SELECT children, MAX(charges) AS max_charges
FROM insurance
GROUP BY children
ORDER BY max_charges DESC;

-- maximum charges are from those having no childrens and it consistently goes down no of children increases

SELECT *
FROM insurance
ORDER BY charges DESC
LIMIT 10;

-- Identified top 10 applicant with high charges 

SELECT smoker, AVG(charges) AS avg_charges
FROM insurance
GROUP BY smoker;

-- Smokers have high average charges than non-smokers


SELECT *
FROM insurance
WHERE bmi > 30 AND age > 50
ORDER BY charges DESC;

-- Charges with high bmi with more than 50 age group ranges widely from 60 thousand to 8 thousand

SELECT
    CASE 
        WHEN charges < 5000 THEN '<5k'
        WHEN charges BETWEEN 5000 AND 10000 THEN '5k-10k'
        WHEN charges BETWEEN 10001 AND 20000 THEN '10k-20k'
        ELSE '>20k'
    END AS charge_range,
    COUNT(*) AS num_claims
FROM insurance
GROUP BY charge_range
ORDER BY charge_range;

-- Applicant with less than 5000 as charge includes 359 claims
-- Applicant between 5000 than 10000 as charge includes 353 claims
-- Applicant between 10000 than 20000 as charge includes 353 claims
-- Applicant with more than 20000 as charge includes 273 claims

SELECT 
    CASE 
        WHEN age < 30 THEN '<30'
        WHEN age BETWEEN 30 AND 45 THEN '30-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    AVG(charges) AS avg_charges,
    COUNT(*) AS num_claims
FROM insurance
GROUP BY age_group
ORDER BY age_group;

-- 417 Applicants fall under 30 yrs age group and has avg charges of 9182
-- 421 Applicants fall between 30-45 yrs age group and has avg charges of 12652
-- 409 Applicants fall between 46-60 yrs age group and has avg charges of 16340
-- 91 Applicants fall above 60 yrs age group and has avg charges of 21063

