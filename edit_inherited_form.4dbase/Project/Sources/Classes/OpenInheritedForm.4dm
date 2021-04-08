Class constructor
	var $1 : Object
	
	
Function onInvoke
	var $1; $0 : Object
	var $tablePtr : Pointer
	var $formName; $tableName : Text
	var $i; $tableNumber : Integer
	var $okEdit : Boolean
	
	If ($1.editor.formProperties.inheritedForm#Null:C1517)
		
		$okEdit:=True:C214
		
		If ($1.editor.formProperties.inheritedForm#"")
			
			$tablePtr:=Null:C1517
			$formName:=$1.editor.formProperties.inheritedForm
			
			If ($1.editor.formProperties.inheritedFormTable#Null:C1517)
				If (Value type:C1509($1.editor.formProperties.inheritedFormTable)=Is text:K8:3)
					$tableName:=$1.editor.formProperties.inheritedFormTable
					If ($tableName#"")
						$tableNumber:=0
						
						// we are in 2021 and there is still no way to retrieve easily a table number from its name
						// the command "Table" should accept a number or a string
						
						For ($i; 1; Get last table number:C254; 1)
							If (Is table number valid:C999($i))
								If (Table name:C256($i)=$tableName)
									$tableNumber:=$i
									$i:=MAXLONG:K35:2-1
								End if 
							End if 
						End for 
						
						If ($tableNumber>0)
							$tablePtr:=Table:C252($tableNumber)
						Else 
							$okEdit:=False:C215
							ALERT:C41("inherited table not found :"+$tableName)
						End if 
					End if 
					
				Else 
					$i:=Value type:C1509($1.editor.formProperties.inheritedFormTable)
					If (($i=Is longint:K8:6) | ($i=Is real:K8:4))
						$tableNumber:=$1.editor.formProperties.inheritedFormTable
						If (Is table number valid:C999($tableNumber))
							$tablePtr:=Table:C252($tableNumber)
						Else 
							$okEdit:=False:C215
							ALERT:C41("Invalid inherited table number :"+String:C10($tableNumber))
						End if 
					End if 
				End if 
			End if 
			If ($okEdit)
				If ($tablePtr#Null:C1517)
					FORM EDIT:C1749($tablePtr->; $formName)
				Else 
					FORM EDIT:C1749($formName)
				End if 
			End if 
		End if 
	End if 
Function onError
	
	var $1; $2 : Object
	var $3 : Collection
	