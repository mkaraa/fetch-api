//
//  ProductsView.swift
//  hizligeliyo
//
//  Created by Metehan kara on 23.12.2020.
//

import SwiftUI
import SDWebImageSwiftUI
import Alamofire
import SwiftyJSON

struct ProductsView: View {
    let categories : [String] = ["Outdoor","Kozmetik","Spor","Teknoloji","Ev Dekorasyon","Yaşam"]
    let hueColors = stride(from: 0, to: 1, by: 0.01).map {
        Color(hue: $0, saturation: 1, brightness: 1)
    }
    @State var category: String = ""
    @ObservedObject var obs = observer()
    
    var body: some View {
        
        TabView {
            VStack{
                HStack  {
                    ZStack (alignment: .trailing) {
                        Image(systemName: "magnifyingglass").foregroundColor(.gray).zIndex(1.0).offset(x:-320, y:0)
                        TextField("Kategori veya ürün ara", text: $category)
                            .offset(x:20, y: 0)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10.0)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            .frame(width: 350, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .trailing)
                        LinearGradient(gradient: Gradient(colors: hueColors),
                                       startPoint: .leading,
                                       endPoint: .trailing).frame(width: 350, height: 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(x:0,y:25).zIndex(0.0)
                        
                    }
                }
                HStack{
                    Image(systemName: "text.alignright").foregroundColor(.gray)
                    Text("Sırala").foregroundColor(.gray)
                    Divider().frame(width: 50, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image(systemName: "line.horizontal.3.decrease.circle.fill").foregroundColor(.gray)
                    Text("Filtre").foregroundColor(.gray)
                }.frame(width: 320, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.leading)
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(20.0)
                .shadow(color: .gray, radius: 1, x: 0, y: 0.5)
                
                HStack{
                    List(obs.datas) {item in
                        card(title: item.title, price: item.price, img: item.img)
                    }
                    
                }
            }
            .tabItem {
                Image(systemName: "house.fill").foregroundColor(.yellow)
            }.tag(0)
            
            NavigationView{
                List(categories, id: \.self) {cat in
                    HStack{
                      
                        Text(cat).frame(height:50).offset(x:40,y:0)
                    }
                    
                }.frame(width: 400, height: 700, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                FilterButton().offset(x:50, y:600)
            }
                
            
            
            
            .tabItem {
                Image(systemName: "square.grid.3x3.fill").foregroundColor(.yellow)
            }.tag(1)
            Text("View")
                .tabItem {
                    Image(systemName: "tag.fill").foregroundColor(.yellow)
                }.tag(1)
            Text("Person")
                .tabItem {
                    Image(systemName: "person.fill").foregroundColor(.yellow)
                }.tag(1)
        }
    }
    
    
}

class observer : ObservableObject{
    @Published var datas = [Product]()
    init(){
        AF.request("https://fakestoreapi.com/products").responseData {
            (data) in
            let json = try! JSON(data: data.data!)
            
            for i in json {
                self.datas.append(Product(
                                    id: i.1["id"].intValue,
                                    title: i.1["title"].stringValue,
                                    category: i.1["category"].stringValue, price: i.1["price"].stringValue,
                                    img: i.1["image"].stringValue))
            }
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}

struct Product: Identifiable {
    let id: Int
    let title: String
    let category: String
    let price: String
    let img : String
}

struct card : View {
    var title = ""
    var price = ""
    var img = ""
    
    var body : some View {
        VStack{
            AnimatedImage(url: URL(string: img)!).resizable()
            
            Text(title)
                .fontWeight(.medium).frame(width: 150, height: 60)
            HStack{
                Text(price)
                    .fontWeight(.medium).frame(width: 150, height: 30).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                
            }
            
        }.frame(width: 150, height: 200).cornerRadius(20).shadow(radius: 5)
    }
}
struct FilterButton: View {
    var body: some View {
        Text("Filtrele")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 300, height: 60,alignment: .center)
            .background(Color(.systemYellow))
            .cornerRadius(30.0)
    }
}
/*
 
 TabView {
 VStack (alignment: .leading, spacing: 15) {
 HStack  {
 ZStack (alignment: .trailing) {
 Image(systemName: "magnifyingglass").foregroundColor(.gray).zIndex(1.0).offset(x:-320, y:0)
 TextField("Kategori veya ürün ara", text: $category)
 .multilineTextAlignment(.leading)
 .padding()
 .background(Color.white)
 .foregroundColor(.black)
 .cornerRadius(10.0)
 .shadow(color: .gray, radius: 2, x: 0, y: 2)
 .frame(width: 350, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .trailing)
 LinearGradient(gradient: Gradient(colors: hueColors),
 startPoint: .leading,
 endPoint: .trailing).frame(width: 350, height: 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(x:0,y:25).zIndex(0.0)
 
 }
 }
 HStack{
 Image(systemName: "circle").foregroundColor(.gray)
 Text("Sırala").foregroundColor(.gray)
 Divider().frame(width: 50, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
 Image(systemName: "circle").foregroundColor(.gray)
 Text("Filtre").foregroundColor(.gray)
 }.frame(width: 300, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
 .multilineTextAlignment(.leading)
 .padding()
 .background(Color.white)
 .foregroundColor(.black)
 .cornerRadius(30.0)
 .shadow(color: .gray, radius: 1, x: 0, y: 1)
 
 List(results, id: \.id) { result in
 Text(result.title)
 }.onAppear(perform: loadData)
 /*
 VStack{
 List(results, id: \.id){ result in
 Image(result.img)
 .resizable()
 .aspectRatio(contentMode: .fit)
 HStack{
 VStack (alignment: .leading){
 Text(result.title)
 .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
 .foregroundColor(.gray)
 Text("Written By Mete")
 .font(.title)
 .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
 }
 .layoutPriority(50)
 Spacer()
 }
 .padding()
 }.onAppear(perform: loadData)
 
 
 }
 .cornerRadius(15.0)
 .overlay(
 RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
 .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1),lineWidth: 1)
 )
 */
 }
 
 .tabItem {
 Image(systemName: "house.fill")
 }.foregroundColor(.yellow)
 Text("Nearby Screen")
 .tabItem {
 Image(systemName: "circle.fill").foregroundColor(.yellow)
 }
 Text("Nearby Screen")
 .tabItem {
 Image(systemName: "tag.fill").foregroundColor(.yellow)
 }
 Text("Friends Screen")
 .tabItem {
 Image(systemName: "person.fill").foregroundColor(.yellow)
 }
 }
 /*
 List(results, id: \.id) { item in
 VStack(alignment: .leading) {
 
 }
 }.onAppear(perform: loadData)
 */
 */
