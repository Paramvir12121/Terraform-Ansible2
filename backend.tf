terraform {
backend "azurerm" {
   resource_group_name  = "9079-Assignment2-RG"
   storage_account_name = "storageaccountparamvir"
   container_name       = "tfstatefiles"
   key                  = "Ou3h+H2q8H4CwJUO1n74pS1l6bFsHe9+KIpoAifPr9/rAEkyYO+pF8Nszg0SLoxPqgwqlgeRJVj6+AStiezYeQ=="
 }
}
