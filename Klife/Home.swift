import SwiftUI
import GoogleSignIn
import Firebase
import FirebaseFirestore
//---------------------------------------------------------------------------
struct Home: View {
    @State private var isShowImage : Bool = true
    var body: some View
    {
        TabView
        {
            Community()
            .tabItem
            {
                Image(systemName: "phone.fill")
                Text("Community")
            }
            Information()
            .tabItem
            {
                Image(systemName: "tv.fill")
                Text("Information")
            }
            Emergency()
            .tabItem
            {
                Image(systemName: "phone.fill")
                Text("Emergency")
            }
            Setting()
            .tabItem
            {
                Image(systemName: "gear")
                Text("Setting")
            }
        }
    }
}
//---------------------------------------------------------------------------
struct Community: View {
    @State private var isShowImage : Bool = true
    @State private var testlist : [CommunityItem] =
        [
            CommunityItem(text: "자유게시판", image: "camera", value:"자유게시판 내용"),
            CommunityItem(text: "정보게시판", image: "cloud", value:"정보게시판 내용"),
            CommunityItem(text: "장터게시판", image: "book", value:"장터게시판 내용"),
            CommunityItem(text: "홍보게시판", image: "star", value:"홍보게시판 내용"),
        ]
    var body: some View
    {
        NavigationView
        {
            List
            {
                Section()
                {
                    ForEach(testlist)
                    {
                        item in
                        HStack
                        {
                            NavigationLink(
                                destination: Text(item.value),
                                label: {
                                    if isShowImage
                                    {
                                        Image(systemName: item.image)
                                    }
                                    Text(item.text)
                                })
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Community"))
        }
    }
}
//---------------------------------------------------------------------------
struct Information: View {
    @State private var isShowImage : Bool = true
    @State private var testlist : [InformationItem] =
        [
            InformationItem(text: "관광지", image: "camera", value:"관광지 정보"),
            InformationItem(text: "쇼핑", image: "cloud", value:"쇼핑 정보"),
            InformationItem(text: "비자", image: "book", value:"비자 발급/갱신 정보"),
            InformationItem(text: "원룸", image: "star", value:"지역별 원룸 추천/대행/가격대 정보"),
        ]
    var body: some View
    {
        NavigationView
        {
            List
            {
                Section()
                {
                    ForEach(testlist)
                    {
                        item in
                        HStack
                        {
                            NavigationLink(
                                destination: Text(item.value),
                                label: {
                                    if isShowImage
                                    {
                                        Image(systemName: item.image)
                                    }
                                    Text(item.text)
                                })
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Information"))
        }
    }
}
//---------------------------------------------------------------------------
struct Emergency: View {
    @State private var isShowImage : Bool = true
    @State private var testlist : [EmergencyItem] =
        [
            EmergencyItem(text: "경찰서", image: "camera", value: "112"),
            EmergencyItem(text: "소방서", image: "cloud", value: "119"),
            EmergencyItem(text: "통신사", image: "book", value: "114"),
            EmergencyItem(text: "외교부", image: "star", value: "K life"),
            EmergencyItem(text: "출입국사무소", image: "alarm", value: "K life"),
            EmergencyItem(text: "통역기관", image: "alarm", value: "K life"),
        ]
    var body: some View
    {
        NavigationView
        {
            List
            {
                Section()
                {
                    ForEach(testlist)
                    {
                        item in
                        HStack
                        {
                            NavigationLink(
                                destination: Text(item.value),
                                label: {
                                    if isShowImage
                                    {
                                        Image(systemName: item.image)
                                    }
                                    Text(item.text)
                                })
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Emergency"))
        }
    }
}
//---------------------------------------------------------------------------
struct Setting: View {
    @State private var isShowImage : Bool = true
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    private let user = GIDSignIn.sharedInstance().currentUser
    @State private var testlist : [SettingItem] =
        [
            SettingItem(text: "회원탈퇴", image: "camera"),
            SettingItem(text: "알림설정", image: "cloud"),
            SettingItem(text: "로그아웃", image: "book"),
        ]
    var body: some View
    {
        NavigationView
        {
            List
            {
                Section()
                {
                    ForEach(testlist)
                    {
                        item in
                        HStack
                        {
                            NavigationLink(
                                destination: Free_Board(Free_board: []),
                                label: {
                                    if isShowImage
                                    {
                                        Image(systemName: item.image)
                                    }
                                    Text(item.text)
                                })

                            }
                        }
                    }
                Button("Sign out") {
                    viewModel.signOut()
                }
            }
            .navigationBarTitle(Text("Setting"))
        }
    }
}
//---------------------------------------------------------------------------
struct Free_Board_DB: Identifiable{
    var id = UUID()
    var title: String
    var body: String
}
//---------------------------------------------------------------------------
struct CommunityItem : Identifiable {
    var id = UUID()
    var text : String
    var image : String
    var value : String
}
//---------------------------------------------------------------------------
struct InformationItem : Identifiable {
    var id = UUID()
    var text : String
    var image : String
    var value : String
}
//---------------------------------------------------------------------------
struct EmergencyItem : Identifiable {
    var id = UUID()
    var text : String
    var image : String
    var value : String
}
//---------------------------------------------------------------------------
struct SettingItem : Identifiable {
    var id = UUID()
    var text : String
    var image : String
}
//---------------------------------------------------------------------------
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
//---------------------------------------------------------------------------
struct NetworkImage: View {
    let url: URL?
    
    var body: some View {
        if let url = url,
           let data = try? Data(contentsOf: url),
           let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
//---------------------------------------------------------------------------
