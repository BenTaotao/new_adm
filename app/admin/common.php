<?php
// 这是系统自动生成的公共文件


use think\facade\App;


function getTree($data, $pId)
{
	$tree = array();
	foreach ($data as $k => $v) {
		if ($v['parent'] == $pId) {         //父亲找到儿子
			$v['parent'] = getTree($data, $v['id']);
			$tree[] = $v;
		}
	}
	return $tree;
}

function getTree_children($data, $pId)
{
	$tree = array();
	foreach ($data as $k => $v) {
		if ($v['parent'] == $pId) {         //父亲找到儿子
			$v['children'] = getTree_children($data, $v['id']);
			unset($v['parent']);
			$tree[] = $v;
		}
	}
	$tree = array_values($tree);
	return $tree;
}

#老的菜单
/*#菜单格式化函数---一级菜单
function procHtml(array $tree,int $id,int $self_id = 0)
{
    $html = '';
    if (is_array($tree)) {
        foreach ($tree as $t) {
            if ((int)$t['parent'] == 0) {
                $a = url($t['name']);
                if ($t['id'] == $id) {
                    $html .= "<li class='layui-nav-item'><a href='javascript:;' data-url='$a'>&nbsp;&nbsp;".$t['title']."</a></li>";
                } else {
                    $html .= "<li class='layui-nav-item'><a href='javascript:;' data-url='$a'>&nbsp;&nbsp;".$t['title']."</a></li>";
                }
            } else {
                if ($t['id'] == $id) {
                    $html .= "<li class='layui-nav-item'><a href='javascript:;'>&nbsp;&nbsp;".$t['title']."</a>";
                } else {
                    $html .= "<li class='layui-nav-item'><a href='javascript:;'>&nbsp;&nbsp;".$t['title']."</a>";
                }
                $html .= "<dl class='layui-nav-child'>";
                $html .= procHtmlIn($t['parent'], $self_id);
                $html .= "</dl>";
                $html = $html . "</li>";
            }
        }
    }
    return $html;
}
#菜单格式化杉树---二级菜单
function procHtmlIn(array $tree, int $self_id)
{
    $html = '';
    foreach ($tree as $t) {
        $a = url($t['name']);
        if ($self_id == $t['id']) {
            $html .= "<dd class='layui-this'><a href='javascript:;' data-url='$a'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;".$t['title']."</a></dd>";
        } else {
            $html .= "<dd><a href='javascript:;' data-url='$a'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;".$t['title']."</a></dd>";
        }
    }
    return $html;
}*/

#新的菜单
#菜单格式化函数---一级菜单
function procHtml(array $tree, int $id, int $self_id = 0)
{
	$html = '';
	if (is_array($tree)) {
		foreach ($tree as $t) {
			/* <a href='javascript:;' data-url='$a'>&nbsp;&nbsp;" . $t['title'] . "</a>*/
			$a = url($t['name']);
			if ((int)$t['parent'] == 0) {

				$html .= "<li>
                                <div class='layui-menu-body-title'>
                                    <a href=\"javascript:void(0);\" data-url=\"{$a}\">{$t['title']}</a>
                                </div>
                            </li>
                            <li class=\"layui-menu-item-divider\"></li>";
			} else {

                $parent_type = 1;
                for ($i = 0;$i<count($t['parent']);$i++){
                    if ($t['parent'][$i]['type'] == 0){
                        $parent_type = 0;
                    }
                }
                if ($parent_type == 1){
                    $html .= "<li>
                                <div class='layui-menu-body-title'>
                                    <a href=\"javascript:void(0);\" data-url=\"{$a}\">{$t['title']}</a>
                                </div>
                            </li>
                            <li class=\"layui-menu-item-divider\"></li>";
                }else{
                    $group = (string) 'lay-options="{type: ' . '\'group' . '\'}"';
                    $html .= "<li class='layui-menu-item-group layui-menu-item-up' " . $group . ">
                                <div class='layui-menu-body-title'>
                                    " . $t['title'] . "<i class=\"layui-icon layui-icon-down\"></i>
                                </div>
                                <ul>";

                    $html .= procHtmlIn($t['parent'], $self_id);
                    $html .= "      </ul>
                            </li>
                            <li class=\"layui-menu-item-divider\"></li>";
                }

			}
		}
	}
	return $html;
}

#菜单格式化杉树---二级菜单
function procHtmlIn(array $tree, int $self_id)
{
	$html = '';

	$parent = (string) 'lay-options="{type: ' . '\'parent' . '\'}"';
	foreach ($tree as $t) {
		/*<a href='javascript:;' data-url='$a'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" . $t['title'] . "</a>*/
		$a = url($t['name']);

		if (is_array($t['parent']) && !empty($t['parent'])) {
			$three_menu_yes = [];
			$three_menu_no = [];
			foreach ($t['parent'] as $v) {
				if ($v['type'] == 0) {
					array_push($three_menu_yes, $v['title']);
				} else {
					array_push($three_menu_no, $v['title']);
				}
			}
			if (!empty($three_menu_yes)) {
				$html .= "
					<li class='layui-menu-item-parent' lay-options=" . $parent . ">
						<div class='layui-menu-body-title'>
							" . $t['title'] . " <i class='layui-icon layui-icon-right'></i>
						</div>";
				for ($i = 0; $i < count($three_menu_yes); $i++) {
					$html .=
						"<div class='layui-panel layui-menu-body-panel'>
							<ul>
								<li>
									<div class='layui-menu-body-title'>
										" . $three_menu_yes[$i] . "
									</div>
								</li>
							</ul>
						</div>";
				}
				$html .= "</li>";
			}

			if (!empty($three_menu_no)) {
				$html .= "<li>
                          <div class='layui-menu-body-title'>
                              <a href='javascript:void(0);' data-url='$a'>" . $t['title'] . "</a>
                          </div>
                      </li>";
			}

			// $html .= "
			// 		<li class='layui-menu-item-parent' lay-options='".$parent."'>
			// 			<div class='layui-menu-body-title'>
			// 				menu item 9-2 <i class='layui-icon layui-icon-right'></i>
			// 			</div>
			// 			<div class='layui-panel layui-menu-body-panel'>
			// 				<ul>
			// 					<li>
			// 						<div class='layui-menu-body-title'>
			// 							menu item 9-2-1
			// 						</div>
			// 					</li>
			// 				</ul>
			// 			</div>
			// 		</li>";
		} else {
			$html .= "<li>
                          <div class='layui-menu-body-title'>
                              <a href='javascript:void(0);' data-url='$a'>" . $t['title'] . "</a>
                          </div>
                      </li>";
		}
	}

	return $html;
}

#三级及和三级以后的菜单
function proHtmlOther($list)
{
	/*/*lay-options="{type: 'parent'}*/
	$html = "<li class='layui-menu-item-parent'>
               <div class='layui-menu-body-title'>
					" . $list['title'] . "<i class='layui-icon layui-icon-right'></i>
               </div>
               <div class='layui-panel layui-menu-body-panel'>
                <ul>
                 <li>
                  <div class='layui-menu-body-title'>
	menu item 9-2-1
	</div></li>
                 <li>
                  <div class='layui-menu-body-title'>
	menu item 9-2-2
	</div></li>
                 <li>
                  <div class='layui-menu-body-title'>
	menu item 9-2-3
	</div></li>
                </ul>
               </div> </li>";
	return $html;
}

