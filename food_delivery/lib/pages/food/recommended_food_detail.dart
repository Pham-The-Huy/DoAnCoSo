import 'package:flutter/material.dart';
import 'package:food_delivery/app/colors.dart';
import 'package:food_delivery/app/dimensions.dart';
import 'package:food_delivery/widgets/BigText.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20))),
                child: Center(
                    child: BigText(
                  text: "Vietnamese Side",
                )),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/pho.jpeg',
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableTextWidget(
                    text:
                        "Trong một buổi sáng sớm đầy sương mù, khi mặt trời vẫn còn ẩn mình sau những đám mây xám xịt, từng tia nắng yếu ớt bắt đầu len lỏi qua những khe lá, chiếu rọi xuống con đường làng ngoằn ngoèo chạy dài như một dải lụa mềm mại, bên hai bên đường là những cánh đồng lúa mênh mông xanh ngát, hương thơm của lúa mới quyện với làn gió nhẹ làm cho không khí trở nên trong lành và dễ chịu, tiếng chim hót líu lo trên những tán cây cao, xa xa là hình ảnh của những người nông dân cần mẫn cày cấy, gương mặt họ ánh lên sự chăm chỉ và niềm vui lao động, từng nhịp cày khẽ khàng lướt qua những mảnh đất màu mỡ, dưới chân họ là bùn đất mềm mại, những chú trâu đen sẫm, to lớn với đôi mắt hiền từ thong thả kéo cày, ở phía xa hơn, nơi cánh đồng tiếp giáp với rừng cây, từng đàn cò trắng tung cánh bay lên, điểm xuyết vào bức tranh thiên nhiên một nét chấm phá đẹp đẽ, rực rỡ như một bản hòa tấu của cuộc sống, có đôi khi giữa lúc công việc bộn bề, người nông dân dừng lại lau giọt mồ hôi trên trán, họ ngẩng đầu nhìn trời cao xanh, lòng dâng tràn hy vọng về một mùa màng bội thu, rồi lại tiếp tục công việc của mình với tinh thần hăng say, tất cả như hoà quyện tạo nên một khung cảnh bình yên, mộc mạc nhưng đầy sức sống và sinh động, không chỉ có vậy, nếu bạn bước thêm một đoạn nữa về phía làng, bạn sẽ bắt gặp hình ảnh của những cụ già ngồi dưới gốc cây đa cổ thụ, tay phe phẩy quạt nan, mắt lim dim nghe những câu chuyện kể từ thời xa xưa, ký ức của họ đầy ắp những kỷ niệm về một thời đã qua, những câu chuyện cổ tích, những truyền thuyết về làng quê luôn là đề tài không bao giờ cũ, trẻ con thì chạy nhảy tung tăng trên những con ngõ nhỏ, tiếng cười nói rộn rã vang vọng khắp nơi, tất cả những âm thanh, hình ảnh ấy đã góp phần tạo nên bức tranh làng quê Việt Nam vừa bình dị, vừa thân thương mà bất cứ ai đi xa cũng không thể nào quên, những lúc như thế, tôi thường nhớ đến quê hương với một niềm nhớ da diết, như một mạch ngầm trong lòng chảy mãi, nuôi dưỡng tâm hồn và mang lại cho tôi sức mạnh để bước tiếp trên con đường đời.",
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20 * 2.5,
                right: Dimensions.width20 * 2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                    iconSize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.remove),
                BigText(
                  text: "\$12.88 " + " X " + " 0 ",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),
                AppIcon(
                    iconSize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.add),
              ],
            ),
          ),
          Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height10,
                        bottom: Dimensions.height10,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    )),
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height10,
                      bottom: Dimensions.height10,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: BigText(
                    text: "\$10 | Add to cart",
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
