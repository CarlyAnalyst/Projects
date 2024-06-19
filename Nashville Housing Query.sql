select *from dbo.NashvilleHousing

Select SaleDate, CONVERT(Date,SaleDate)
From dbo.NashvilleHousing

alter table NashvilleHousing
add SaleDateConverted date

update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)


Select saleDateConverted, CONVERT(Date,SaleDate)
From dbo.NashvilleHousing


Select PropertyAddress
From dbo.NashvilleHousing
where PropertyAddress is null


Select *
From dbo.NashvilleHousing
--where PropertyAddress is null
order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From dbo.NashvilleHousing a
join dbo.NashvilleHousing b
     on a.ParcelID = b.ParcelID
	 and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress= ISNULL(a.PropertyAddress, b.PropertyAddress)
From dbo.NashvilleHousing a
join dbo.NashvilleHousing b
     on a.ParcelID = b.ParcelID
	 and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

Select PropertyAddress
From dbo.NashvilleHousing
--where PropertyAddress is null
--order by ParcelID

select
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)as Address

From dbo.NashvilleHousing


select
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress))as Address,
CHARINDEX(',',PropertyAddress)

From dbo.NashvilleHousing


select
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)as Address
, SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) as Address
From dbo.NashvilleHousing

alter table NashvilleHousing
add PropertySplitAddress nvarchar(250)

update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

alter table NashvilleHousing
add PropertySplitCity nvarchar(250)

update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress))

select * from dbo.NashvilleHousing


select OwnerAddress 
from dbo.NashvilleHousing

select
PARSENAME(REPLACE(OwnerAddress,',','.'),3)
,PARSENAME(REPLACE(OwnerAddress,',','.'),2)
,PARSENAME(REPLACE(OwnerAddress,',','.'),1)
from dbo.NashvilleHousing

alter table NashvilleHousing
add OwnerSplitAddress nvarchar(250)

update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

alter table NashvilleHousing
add OwnerSplitCity nvarchar(250)

update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

alter table NashvilleHousing
add OwnerSplitState nvarchar(250)

update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)

select*from dbo.NashvilleHousing

select DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
from dbo.NashvilleHousing
group by SoldAsVacant
order by 2


Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
from dbo.NashvilleHousing


Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
WITH RowNumCTE AS(
select *,
  ROW_NUMBER() OVER(
  PARTITION BY ParcelID,
               PropertyAddress,
			   SalePrice,
			   SaleDate,
			   LegalReference
			   order by
			    UniqueID
				) row_num

from dbo.NashvilleHousing
--order by ParcelID
)
SELECT*
from RowNumCTE
where row_num>1
order by PropertyAddress



WITH RowNumCTE AS(
select *,
  ROW_NUMBER() OVER(
  PARTITION BY ParcelID,
               PropertyAddress,
			   SalePrice,
			   SaleDate,
			   LegalReference
			   order by
			    UniqueID
				) row_num

from dbo.NashvilleHousing
--order by ParcelID
)
select * 
from RowNumCTE
where row_num>1
order by PropertyAddress


select *
from dbo.NashvilleHousing


ALTER TABLE dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate 



