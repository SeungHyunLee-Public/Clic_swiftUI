import SwiftUI
import GoogleSignIn
import Firebase
import FirebaseFirestore

struct Free_Board: View {

    @State var Free_board_title=""
    @State var Free_board_body=""
    @State var Free_board:[Free_Board_DB]
    @State var showSheet = false
    @State var body_id = ""
    @State var showActionSheet = false
    @State private var action: Int? = 0
    var body: some View
    {
        VStack
        {


            ScrollView {
                if Free_board.count > 0 {
                    ForEach(Free_board, id: \.id){thisFree_Board_DB in
                        Button(action: {
                            self.body_id = thisFree_Board_DB.id.uuidString
                            self.Free_board_title = thisFree_Board_DB.title
                            self.Free_board_body = thisFree_Board_DB.body
                            self.showSheet = true
                        }) {
                            HStack{

                            Text("\(thisFree_Board_DB.title) \n \(thisFree_Board_DB.body)")
                                .frame(maxWidth:UIScreen.main.bounds.size.width, alignment: .topLeading)
                                .foregroundColor(.black)

                            }.background(Color.blue)
                            }.sheet(isPresented: self.$showSheet){
                            VStack{
                                Text("Modify body - \(self.body_id)")
                                TextField("Add a Free_Board_DB", text:
                                        self.$Free_board_title)
                                TextField("Rate this3 Free_Board_DB", text:
                                        self.$Free_board_body)
                                    .keyboardType(.numberPad)
                                    .padding()
                                HStack{
                                    Button(action: {

                                    let bodyDictionary = [
                                        "title":self.Free_board_title,
                                        "body":self.Free_board_body
                                    ]

                                    let docRef =
                                        Firestore.firestore()
                                        .document("Free_Board/\(body_id)")
                                    print("setting data")
                                    docRef.setData(bodyDictionary, merge: true) { (error) in
                                        if let error = error
                                        {
                                            print("error = \(error)")
                                        }
                                        else {
                                            print("data updated  successfully")
                                            self.Free_board_title = ""
                                            self.Free_board_body = ""
                                        }
                                    }
                                }){
                                        Text("Update")
                                        .padding()
                                            .background(Color.init(red:0.92, green:0.92, blue:0.92))
                                            .foregroundColor(.black)
                                        .cornerRadius(5)
                                    }.padding()
                                    Button(action: {
                                        self.showActionSheet = true

                                    }){
                                        Text("Delete")
                                            .padding()
                                            .background(Color.init(red:1, green:0.9, blue:0.9))
                                        .foregroundColor(.red)
                                        .cornerRadius(5)
                                    }.padding()
                                    .actionSheet(isPresented:
                                        self.$showActionSheet){
                                        ActionSheet(title: Text("Delete"),
                                               message:Text("Are you sure you want to delete this Item?"), buttons:[
                                                .default(Text("yes"), action: {
                                                    Firestore.firestore()
                                                        .collection("Free_Board")
                                                        .document("\(self.body_id)").delete() {
                                                            err in
                                                            if let err = err {
                                                                print("Error removing document: \(err)")
                                                            }
                                                            else {
                                                                print("body successfully removed!")
                                                                self.showSheet = false
                                                            }
                                                        }
                                                })
                                                ,
                                                .cancel()
                                            ])
                                    }

                                }
                            }
                        }
                    }
                }else
                {
                    Text("Submit a rebiew")
                }
            }.frame(width: UIScreen.main.bounds.size.width)
                .background(Color.red)
            NavigationLink(
                destination:Add_gaesigeul(Free_board: []),
                label :{
                    Text("add new board")
                })
        }.onAppear(){
            Firestore.firestore().collection("Free_Board")
            .addSnapshotListener {querySnapshot, error in
                guard let documents = querySnapshot?.documents else
                {
                    print("Error fetching documents: \(error!)")
                    return
                }

                let titles = documents.map {$0["title"]}
//                let titles = documents.map {$0["title"]!}
                let Free_Board = documents.map {$0["body"]}
//                let Free_Board = documents.map {$0["body"]!}
                print(titles)
                print(Free_Board)
                self.Free_board.removeAll()
                for i in 0..<titles.count
                {
                    self.Free_board.append(Free_Board_DB(id: UUID(uuidString:documents[i].documentID) ?? UUID(),
                        title: titles[i] as? String ?? "failed to get title",
                        body: Free_Board[i] as? String ?? "failed to get bodys"))
                }
            }
        }
    }
}
//---------------------------------------------------------------------------
struct Add_gaesigeul: View {
    
    @State var Free_board_title=""
    @State var Free_board_body=""
    @State var Free_board:[Free_Board_DB]
    @State var showSheet = false
    @State var body_id = ""
    @State var showActionSheet = false
    @State private var action: Int? = 0

    var body: some View
    {
        VStack
        {
            TextField("Add a new name", text: $Free_board_title).padding()
            TextEditor(text: $Free_board_body)
                .padding()
                            .background(Color.yellow.opacity(0.5))
                            .foregroundColor(Color.yellow)
                            .font(Font.custom("AvenirNext-Regular", size: 20, relativeTo: .body))
                            .frame(width: 300, height: 250)
                            .cornerRadius(25)
                            Button(action: {
                                let bodyDictionary = [
                                    "title":self.Free_board_title,
                                    "body":self.Free_board_body
                    ]

                    let docRef = Firestore.firestore().document("Free_Board/\(UUID().uuidString)")
                    print("setting data")
                    docRef.setData(bodyDictionary) { (error) in
                        if let error = error
                        {
                            print("error = \(error)")
                        }
                        else {
                            print("data uploaded successfully")
                            self.showSheet = false
                            self.Free_board_title = ""
                            self.Free_board_body = ""
                        }
                    }
                })
                            {
                    Text("글 추가")
                }
            Spacer()
//        }
        }
        
        }
    }
//-------------------------------------------------------------
struct Place: View {
        @State private var yourText: String = "YOUR PLACEHOLDER TEXT"
        var body: some View {
                TextEditor(text: $yourText)
        }
}
//-------------------------------------------------------------------
struct Add_Previews: PreviewProvider {
    static var previews: some View {
        Add_gaesigeul(Free_board: [])
    }
}
