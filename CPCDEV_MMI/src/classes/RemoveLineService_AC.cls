public with sharing class RemoveLineService_AC {
	
	public void removeItemFromSummaryLine(Integer lineCount, String itemId, String lineId, list<HomeBaseBeans.quoteLine> summaryLineInEdit){
		system.debug('-----------summaryLineInEdit-----'+summaryLineInEdit);
		for(Integer iterator = 0;  iterator < summaryLineInEdit.size(); iterator++){
			if(summaryLineInEdit[iterator].lineId != '' && summaryLineInEdit[iterator].lineId != null){
				system.debug('-----------summaryLineInEdit------if1--------');
				if(summaryLineInEdit[iterator].lineId == lineId){
					system.debug('-----------summaryLineInEdit------if1.1--------');
					summaryLineInEdit[iterator].removeLine = 'true';
					break;
				}
			}else{
				if(summaryLineInEdit[iterator].lineCount == lineCount && summaryLineInEdit[iterator].itemId == itemId){
					// remove this newly added item
					system.debug('-----------summaryLineInEdit------if2--------');
					summaryLineInEdit.remove(iterator);
					break;
				}
			}
		}
		system.debug('-----------summaryLineInEdit------ar--------'+summaryLineInEdit);
	}
	
	public void addNewItemToSummaryLine(HomeBaseBeans.quoteLine HBQ, list<HomeBaseBeans.quoteLine> summaryLineInEdit){
		summaryLineInEdit.add(HBQ);
		system.debug('-----------summaryLineInEdit------aa--------'+summaryLineInEdit);
	}
	
	public list<HomeBaseBeans.quoteLine> CreateDuplicateCopyOfSummaryLine(list<HomeBaseBeans.quoteLine> summaryLine){
		list<HomeBaseBeans.quoteLine> clonedProductList = new list<HomeBaseBeans.quoteLine>();
		for(HomeBaseBeans.quoteLine hq : summaryLine){
			HomeBaseBeans.quoteLine hqObj = new HomeBaseBeans.quoteLine();
			hqObj = hq;
			/*hqObj.itemId = hq.itemId;
			hqObj.ecode = hq.ecode;
			hqObj.reference = hq.reference;
			hqObj.description = hq.description;
			hqObj.lineValue = hq.lineValue;
			hqObj.quantity = hq.quantity;
			hqObj.price = hq.price;
			hqObj.estimatedCost = hq.estimatedCost;
			hqObj.payment = hq.payment;
			hqObj.modificationCharge = hq.modificationCharge;
			hqObj.internetCoupon = hq.internetCoupon;
			hqObj.lockItemCode = hq.lockItemCode;
			hqObj.commission1 = hq.commission1;
			hqObj.commission2 = hq.commission2;
			hqObj.commission3 = hq.commission3;
			hqObj.commission4 = hq.commission4;
			hqObj.invoiceDiscountApplicable = hqObj.invoiceDiscountApplicable;
			HomeBaseBeans.rates rate1 = new HomeBaseBeans.rates();
			HomeBaseBeans.rates rate2 = new HomeBaseBeans.rates();
			HomeBaseBeans.rates rate3 = new HomeBaseBeans.rates();
			HomeBaseBeans.rates rate4 = new HomeBaseBeans.rates();
			HomeBaseBeans.rates rate5 = new HomeBaseBeans.rates();
			HomeBaseBeans.rates rate6 = new HomeBaseBeans.rates();
			HomeBaseBeans.rates rate7 = new HomeBaseBeans.rates();
			HomeBaseBeans.rates rate8 = new HomeBaseBeans.rates();
			
			hqObj.rate1 = hq.rate1;
			hqObj.rate2 = hq.rate2;
			hqObj.rate3 = hq.rate3;
			hqObj.rate4 = hq.rate4;
			hqObj.rate5 = hq.rate5;
			hqObj.rate6 = hq.rate6;
			hqObj.rate7 = hq.rate7;
			hqObj.rate8 = hq.rate8;
			HomeBaseBeans.chargeCodes chargeCode = new HomeBaseBeans.chargeCodes();
			hqObj.chargeCode = hq.chargeCode;
			
			hqObj.errorMessage = hq.errorMessage;
			hqObj.lineCount = hq.lineCount;
			hqObj.isSelected = hq.isSelected;
			hqObj.LockType = hq.LockType;
			hqObj.SelectedAccountId = hq.SelectedAccountId;
			hqObj.SelectedPeriod = hq.SelectedPeriod;
			hqObj.SelectedFromDate = hq.SelectedFromDate;
			hqObj.SelectedRate1 = hq.SelectedRate1;
			hqObj.SelectedRate2 = hq.SelectedRate2;
			hqObj.SelectedRate3 = hq.SelectedRate3;
			hqObj.SelectedRate4 = hq.SelectedRate4;
			hqObj.LockTypeTotal = hq.LockTypeTotal;
			hqObj.lineId = hq.lineId;
			hqObj.removeLine = hq.removeLine;
			hqObj.gpPercent = hq.gpPercent;
			hqObj.netBookValue = hq.netBookValue;
			hqObj.paymentType = hq.paymentType;
			HomeBaseBeans.payment payment1 = new HomeBaseBeans.payment();
			HomeBaseBeans.payment payment2 = new HomeBaseBeans.payment();
			HomeBaseBeans.payment payment3 = new HomeBaseBeans.payment();
			hqObj.payment1 = hq.payment1;
			hqObj.payment2 = hq.payment2;
			hqObj.payment3 = hq.payment3;
			hqObj.isAccessories = hq.isAccessories;*/
			clonedProductList.add(hqObj);
		}
		return clonedProductList;
	}
}