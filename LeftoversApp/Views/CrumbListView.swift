//
//  CrumbList.swift
//  Leftovers
//
//  Created by 109895 on 7.10.2021.
//

import SwiftUI

class DirtyAcess:ObservableObject{
    @Published var needsRefresh:Bool = true;
}

struct CrumbListView: View {
    
    @State var initialize:Bool = true;
    @StateObject private var crumbViewModel:CrumbViewModel = CrumbViewModel();
    @State var searchText:String = ""
    
    func TextFieldWithClear(title:String,text:Binding<String>)-> some View{
        
        //UITextField.appearance().clearButtonMode = UITextField.ViewMode.always
        
        return TextField(title,text:text, onEditingChanged:{_ in editingChanged()},onCommit:{searchFieldCommitted()})
        
    }
    func editingChanged(){
        
    }
    func clearSearchField(){
        searchText = "";
        fetchCrumbs();
    }
    func searchFieldCommitted(){
        
        crumbViewModel.filter(filterText:searchText);
    }
    /**
     IF you are sure that you have deleted the entry never ever requery the datasource
     */
    func deleteCrumbs(at indexSet:IndexSet){
        indexSet.forEach{
            index in
            let selectedCrumb = crumbViewModel.crumbs[index];
            crumbViewModel.deleteCrumb(crumb: selectedCrumb)
        }
        fetchCrumbs();
    }
    func fetchCrumbs(){
        
        crumbViewModel.getCrumbs()
    }
    
    
    var body: some View {
        
            
            NavigationView{
               
                VStack{
                    HStack{
                     
                            TextFieldWithClear(title: "Search", text:$searchText).textFieldStyle(RoundedBorderTextFieldStyle())
                            
                        if searchText.isEmpty == false{
                            
                            Button(action: {clearSearchField()})
                            {
                                Image(systemName: "clear.fill")
                            }.foregroundColor(.red)
                        }
                        
                        Menu(content: { Button("Date -> Oldest First", action: {crumbViewModel.sortByKey(key: CrumbViewModel.CREATE_DATE, direction: 0)})
                                Button("Date -> Recent First", action: {crumbViewModel.sortByKey(key: CrumbViewModel.CREATE_DATE, direction: 1)})
                                Button("Due Date -> Oldest First", action: {crumbViewModel.sortByKey(key: CrumbViewModel.DUE_DATE, direction: 0)})
                                Button("Due Date -> Recent First", action: {crumbViewModel.sortByKey(key: CrumbViewModel.DUE_DATE, direction: 1)})}, label: {return Label(
                                    title: { Text("") },
                                    icon: { Image(systemName: "arrow.down.circle") }
                                )})
                        
                    }.padding(EdgeInsets(top:10,leading: 10,bottom: 20,trailing: 10))
                    ZStack{
                        
                        List{
                            ForEach(crumbViewModel.crumbs,id : \.Id){
                                crumb in
                                NavigationLink(destination: CrumbDetailView(param : crumb.Id))
                                {
                                    CrumbRow(crumb: crumb)
                                }
                            }.onDelete(perform: deleteCrumbs)
                            
                        }.onAppear(perform: {
                            if initialize{
                                fetchCrumbs()
                                initialize = false;
                                return;
                            }
                            else{
                                
                                if(crumbViewModel.isDirty){
                                    crumbViewModel.saveChanges();
                                }
                                fetchCrumbs()
                            }
                        }).background(Color.pink).navigationBarHidden(true)
                        
                        
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                
                                NavigationLink(destination:CrumbDetailView(param:nil).environmentObject(crumbViewModel)){
                                 Text("+")
                                 .font(.system(.largeTitle))
                                 .frame(width: 77, height: 70)
                                 .foregroundColor(Color.white)
                                 .padding(.bottom, 7)
                                 
                                 .background(Color.pink)
                                 .cornerRadius(38.5)
                                 .padding()
                                 .shadow(color: Color.black.opacity(0.3),
                                 radius: 3,
                                 x: 3,
                                 y: 3)
                                 }
                                 
                            }
                        }
                    }.environmentObject(crumbViewModel).padding(EdgeInsets(top:-15,leading:-20,bottom: 0,trailing:-15))
                    
                }
                
            }.padding(EdgeInsets(top:0,leading:0,bottom: 0,trailing:0))
        }
        
    }


struct CrumbList_Previews: PreviewProvider {
    static var previews: some View {
        CrumbListView()
    }
}
